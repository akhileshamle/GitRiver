//  GTRUserDetailsViewController.swift
//  GitRiver
//  Created by Akhilesh Amle on 25/01/19.
//  Copyright © 2019 AkhileshAmle. All rights reserved.

import UIKit

class GTRUserDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblUserName : UILabel!
    
    // MARK: - Variables
    var userDetails : User?
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        self.updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.navigationController?.navigationBar.isHidden = false
    }
    
    private func updateUI() {
        
        if let userDetails = self.userDetails {
            
            self.title = userDetails.login
            
            self.lblUserName.text = userDetails.url
        }
    }
    
    @IBAction func goBack(_ sender: Any?) {
        self.navigationController?.popViewController(animated: true)
    }
}
