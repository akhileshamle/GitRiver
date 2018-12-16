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
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    // MARK: - Public
    // MARK: - Private
    private func initialSetup() {
        self.setupTableView()
    }
    
    private func setupTableView() {
//        self.tableView.register(UINib(nibName: "", bundle: Bundle.main), forCellReuseIdentifier: "")
    }
    
    @objc private func dismissKeyboard() {
        self.searchBar.resignFirstResponder()
    }
}

extension GTRHomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = self.users[indexPath.row] {
            print(user)
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        if let user = self.users[indexPath.row] {
            cell.textLabel?.text = user.login
        }
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension GTRHomeViewController : UISearchBarDelegate {
    
    // MARK: - Private
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
