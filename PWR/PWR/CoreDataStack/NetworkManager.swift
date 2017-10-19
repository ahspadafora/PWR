//
//  NetworkManager.swift
//  PWR
//
//  Created by Amber Spadafora on 10/18/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation
import CoreData

enum Chamber: String {
    case house = "House"
    case senate = "Senate"
}

enum proPublicaKeys: String {
    case firstname = "first_name"
    case lastname = "last_name"
    case st = "state"
    case phone = "phone"
    
    case id = "id"
    case party = "party" // senate party key
    
    case cContactUrl = "url" // congress contact url
    case sContactUrl = "contact_form"
}



class NetworkManager {
    
    static let shared = NetworkManager()
    private init(){
        self.addAPIDataToCoredata()
    }
    
    lazy var coreDataStack = CoreDataStack(modelName: "CoreDataModel")
    
    private func addAPIDataToCoredata(){
        let stateRequest = State.createFetchRequest()
        let senatorRequest = Senator.createFetchRequest()
        let repRequest = Representative.createFetchRequest()
        do {
            let states = try self.coreDataStack.managedContext.fetch(stateRequest)
            let senators = try self.coreDataStack.managedContext.fetch(senatorRequest)
            let reps = try self.coreDataStack.managedContext.fetch(repRequest)
            if states.count == 0 || senators.count == 0 || reps.count == 0 {
                self.removeState()
                self.removeSenatorsAndRepsFromCoreData()
                self.addStatesToCoreData()
                self.fetchChamberMembers(chamber: .house)
                self.fetchChamberMembers(chamber: .senate)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func applicationDocumentsDirectory() {
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
    
    func getStateFetchedResultsController() -> NSFetchedResultsController<NSFetchRequestResult> {
        let stateFetchRequest = State.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "fullname", ascending: true)
        stateFetchRequest.sortDescriptors = [sortDescriptor]
        let controller = NSFetchedResultsController(fetchRequest: stateFetchRequest, managedObjectContext: self.coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }
    
    func dumpCoreData(){
        let stateRqst = State.createFetchRequest()
        do {
            let states = try self.coreDataStack.managedContext.fetch(stateRqst)
            if states.count > 0 {
                print("These are the senators for \(states[0].fullname): \(states[0].senators?.allObjects)")
            }
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func fetchChamberMembers(chamber: Chamber) {
        guard let validEndpoint = Endpoints.getMemberEndPoint(chamber: chamber) else { return }
        APIManager.instance.getData(on: validEndpoint) { (data) in
            do {
                guard let data = data else { return }
                guard let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                self.memberJsonToCoreData(jsonData: jsonData)
                //print(jsonData)
            }
            catch let error as NSError {
                print("Error getting data from senator endpoint, \(error.localizedDescription)")
            }
        }
    }
    
    private func memberJsonToCoreData(jsonData: [String: AnyObject]) {
        guard let results = jsonData["results"] as? [[String: AnyObject]] else { return }
        guard let result = results.first else { return }
        guard let chamber = result["chamber"] as? String else { return }
        guard let members = result["members"] as? [[String: AnyObject]] else { return }
        switch chamber {
        case Chamber.house.rawValue :
            DispatchQueue.main.async { [unowned self] in
                for member in members {
                    let rep = Representative(context: self.coreDataStack.managedContext)
                    self.configureRepresentative(rep, dict: member)
                }
                self.coreDataStack.saveContext()
            }
        case Chamber.senate.rawValue :
            DispatchQueue.main.async { [unowned self] in
                for member in members {
                    let senator = Senator(context: self.coreDataStack.managedContext)
                    self.configureSenator(senator, dict: member)
                }
                self.coreDataStack.saveContext()
            }
        default:
            return
        }
        
    }
    
    private func configureRepresentative(_ rep: Representative, dict: [String: AnyObject]) {
        guard let fname = dict[proPublicaKeys.firstname.rawValue] as? String else { return }
        guard let lname = dict[proPublicaKeys.lastname.rawValue] as? String else { return }
        guard let stateAbbreviation = dict[proPublicaKeys.st.rawValue] as? String else { return }
        guard let phone = dict[proPublicaKeys.phone.rawValue] as? String else { return }
        let contactUrl = dict[proPublicaKeys.cContactUrl.rawValue] as? String
        guard let party = dict[proPublicaKeys.party.rawValue] as? String else { return }
        guard let id = dict[proPublicaKeys.id.rawValue] as? String else { return }
            
        rep.firstName = fname
        rep.lastName = lname
        rep.state = getStateForMember(stateAbbreviation: stateAbbreviation)
        rep.phoneNumber = phone
        rep.contactUrl = contactUrl
        rep.party = party
        rep.id = id
        
        guard let state = rep.state else { return }
        state.addToRepresentatives(rep)
        print("State: \(state.fullname) State representatives: \(state.representatives?.count)")
    }
    
    private func configureSenator(_ senator: Senator, dict: [String: AnyObject]) {
        guard let fname = dict[proPublicaKeys.firstname.rawValue] as? String else { return }
        guard let lname = dict[proPublicaKeys.lastname.rawValue] as? String else { return }
        guard let stateAbbreviation = dict[proPublicaKeys.st.rawValue] as? String else { return }
        guard let phone = dict[proPublicaKeys.phone.rawValue] as? String else { return }
        guard let id = dict[proPublicaKeys.id.rawValue] as? String else { return }
        guard let party = dict[proPublicaKeys.party.rawValue] as? String else { return }
        guard let contactUrl = dict[proPublicaKeys.sContactUrl.rawValue] as? String else { return }
        
        senator.firstName = fname
        senator.lastName = lname
        senator.state = getStateForMember(stateAbbreviation: stateAbbreviation)
        senator.phoneNumber = phone
        senator.id = id
        senator.party = party
        senator.contactUrl = contactUrl
        guard let state = senator.state else { return }
        state.addToSenators(senator)
        print("State: \(state.fullname) State senators: \(state.senators?.count)")
    }
    
    private func getStateForMember(stateAbbreviation: String) -> State? {
        var state: State?
        let stateRequest = State.createFetchRequest()
        stateRequest.predicate = NSPredicate(format: "abbreviation == %@", stateAbbreviation.uppercased())
        do {
            let states = try self.coreDataStack.managedContext.fetch(stateRequest)
            if states.count > 0 {
                state = states[0]
            } else {
                print("no state in db for stateAbbreviation: \(stateAbbreviation)")
            }
        } catch let error as NSError {
            print(error)
        }
        return state
    }
    
    private func addStatesToCoreData(){
        self.removeState()
        for (stateAbbrev, stateName) in States.stateDictionary {
            let state = State(context: self.coreDataStack.managedContext)
            state.abbreviation = stateAbbrev
            state.fullname = stateName
        }
        self.coreDataStack.saveContext()
    }

    func removeSenatorsAndRepsFromCoreData(){
        // create the delete request for the specified entity
        let senatorFetchRequest = Senator.createFetchRequest()
        let repFetchRequest = Representative.createFetchRequest()
        let senDeleteRequest = NSBatchDeleteRequest(fetchRequest: senatorFetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        let repDeleteRequest = NSBatchDeleteRequest(fetchRequest: repFetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        // perform the delete
        do {
            try self.coreDataStack.managedContext.execute(senDeleteRequest)
            try self.coreDataStack.managedContext.execute(repDeleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func removeState(){
        let stateRequest = State.createFetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: stateRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try self.coreDataStack.managedContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
}





