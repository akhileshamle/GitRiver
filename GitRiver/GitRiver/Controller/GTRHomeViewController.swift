//  GTRHomeViewController.swift
//  GitRiver
//  Created by Akhilesh Amle on 08/12/18.
//  Copyright © 2018 AkhileshAmle. All rights reserved.

import UIKit

class GTRHomeViewController: UIViewController {
    // MARK: - Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    lazy var tapRecognizer : UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        return recognizer
    }()
    
    var users : [User?] = []
    var queryService = GetUsersQueryService()
    
    private var selectedUser : User?
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Public
    // MARK: - Private
    private func initialSetup() {
        
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField {
            
            textFieldInsideSearchBar.textColor = UIColor.white
        }
        
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: Constants.Strings.ViewIdentifiers.gtrHomeUserTableViewCell, bundle: Bundle.main), forCellReuseIdentifier: Constants.Strings.ViewIdentifiers.gtrHomeUserTableViewCell)
    }
    
    @objc private func dismissKeyboard() {
        self.searchBar.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let userDetailsViewController = segue.destination as? GTRUserDetailsViewController {
            
            userDetailsViewController.userDetails = self.selectedUser
        }
    }
}

// MARK: - UITableViewDelegate
extension GTRHomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = self.users[indexPath.row] {
            self.selectedUser = user
            
            performSegue(withIdentifier: Constants.Strings.SegueIdentifiers.nextViewController, sender: nil)
        }
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let view = UIView()
//        
//        return view
//    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        //view.backgroundColor = UIColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 1)
        return view
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
        }
    }
}

// MARK: - UITableViewDataSource
extension GTRHomeViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Strings.ViewIdentifiers.gtrHomeUserTableViewCell, for: indexPath) as! GTRHomeUserTableViewCell
        
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        if let user = self.users[indexPath.row] {
            //cell.textLabel?.text = user.login
            cell.lblTitle.text = user.login
        }
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension GTRHomeViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // TODO: start activity
        self.activityIndicator.startAnimating()
        
        queryService.getSearchResults(searchedTerm: searchText) { (currentUsers, errorMessage) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let users = currentUsers {
                self.users = users
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
            
            if errorMessage != nil {
                // TODO: show alert
                self.activityIndicator.stopAnimating()
            }
            self.activityIndicator.stopAnimating()
        }
    }
}
