///  GTRHomeViewController.swift
//  GitRiver
//  Created by Akhilesh Amle on 08/12/18.
//  Copyright © 2018 AkhileshAmle. All rights reserved.

import UIKit

class GTRHomeViewController: UIViewController {
    // MARK: - Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    lazy var tapRecognizer : UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        return recognizer
    }()
    
    var searchedItems : [SearchedItem] = []
    var queryService = GetSearchedResultQueryService()
    
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

// MARK: - UITableViewDataSource
extension GTRHomeViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}
