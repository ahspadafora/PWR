//
//  CoSponsershipViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/13/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class CoSponsershipViewController: UIViewController {

    @IBOutlet weak var bannerView: BannerView!
    @IBOutlet weak var tableView: UITableView!
    
    // Properties
    
    var cosponsorships: [Bill]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bannerView.label.text = ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CoSponsershipViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cosponsorships?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bill", for: indexPath)
        
        cell.textLabel?.text = cosponsorships[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueToBillDetailVC, sender: self)
    }
}
