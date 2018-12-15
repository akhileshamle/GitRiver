//  GetSearchedResultQueryService.swift
//  GitRiver
//  Created by Akhilesh Amle on 06/12/18.
//  Copyright © 2018 AkhileshAmle. All rights reserved.

import UIKit

class GetUsersQueryService: NSObject {

//    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([User]?, String?) -> ()

    var users : Users?
    var errorMessage : String?
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask : URLSessionDataTask?
    
    // Get searched results
    func getSearchResults(searchedTerm: String, completion: @escaping QueryResult) {
        
        self.dataTask?.cancel()
        if var urlComponents = URLComponents(string: Constants.Strings.APIPath.getSearchedUser + "\(searchedTerm)") {
//            urlComponents.query = Constants.Strings.APIPath.getSearchedUser+"\(searchedTerm)"
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, error) in
                defer { self.dataTask = nil }
                if let error = error {
                    self.errorMessage = "DataTask error: " + error.localizedDescription + "\n"
                } else {
                    if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        
                         self.updateSearchResults(data)
                        DispatchQueue.main.async {
                            completion(self.users?.items, self.errorMessage)
                        }
                    }
                }
            })
            dataTask?.resume()
        }
    }
    
    private func updateSearchResults(_ data: Data) {
        var resultJSON : [String:Any] = [:]
        let currentUsers = Users()
        
        
        do {
            guard let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {return}
            resultJSON = responseJSON
        } catch let parseError as NSError {
            self.errorMessage = "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let total_count = resultJSON["total_count"] as? Double else {return}
        currentUsers.total_count = total_count
        
        guard let incomplete_results = resultJSON["incomplete_results"] as? Bool else {return}
        currentUsers.incomplete_results = incomplete_results
        
        guard let items = resultJSON["items"] as? [[String:Any]] else {
            self.errorMessage = "Dictionary doesn't contain items array\n"
            return
        }
        
        for item in items {
            if let login = item["login"] as? String,
                let git_id = item["id"] as? Double,
                let node_id = item["node_id"] as? String,
                let avatar_url = item["avatar_url"] as? String,
                let gravatar_id = item["gravatar_id"] as? String,
                let url = item["url"] as? String,
                let html_url = item["html_url"] as? String,
                let followers_url = item["followers_url"] as? String,
                let gists_url = item["gists_url"] as? String,
                let starred_url = item["starred_url"] as? String,
                let subscriptions_url = item["subscriptions_url"] as? String,
                let organizations_url = item["organizations_url"] as? String,
                let repos_url = item["repos_url"] as? String,
                let events_url = item["events_url"] as? String,
                let received_events_url = item["received_events_url"] as? String,
                let type = item["type"] as? String,
                let site_admin = item["site_admin"] as? Bool,
                let score = item["site_admin"] as? Double {
                currentUsers.items.append(User(login: login, git_id: git_id, node_id: node_id, avatar_url: avatar_url, gravatar_id: gravatar_id, url: url, html_url: html_url, followers_url: followers_url, gists_url: gists_url, starred_url: starred_url, subscriptions_url: subscriptions_url, organizations_url: organizations_url, repos_url: repos_url, events_url: events_url, received_events_url: received_events_url, type: type, site_admin: site_admin, score: score))
            }
        }
        self.users = currentUsers
    }
}
