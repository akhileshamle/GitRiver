//
//  GetSearchedResultQueryService.swift
//  GitRiver
//
//  Created by Akhilesh Amle on 06/12/18.
//  Copyright © 2018 AkhileshAmle. All rights reserved.
//

import UIKit

class GetSearchedResultQueryService: NSObject {

    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([SearchedItem]?, String) -> ()
    
    var searchedItems : [SearchedItem] = []
    var errorMessage = ""
    
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
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else {
                    if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        
                         self.updateSearchResults(data)
                        DispatchQueue.main.async {
                            completion(self.searchedItems, self.errorMessage)
                        }
                    }
                }
            })
            dataTask?.resume()
        }
    }
    
    private func updateSearchResults(_ data: Data) {
        
        var response : JSONDictionary?
        self.searchedItems.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            self.errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let items = response!["items"] as? [JSONDictionary] else {
            errorMessage += "Dictionary doesn't contain items array\n"
            return
        }
        
        var index = 0
        
        for item in items {
            if let itemDictionary = item as? JSONDictionary,
                let login = itemDictionary["login"] as? String,
                let git_id = itemDictionary["id"] as? Double,
                let node_id = itemDictionary["node_id"] as? String,
                let avatar_url = itemDictionary["avatar_url"] as? String,
                let gravatar_id = itemDictionary["gravatar_id"] as? String,
                let url = itemDictionary["url"] as? String,
                let html_url = itemDictionary["html_url"] as? String,
                let followers_url = itemDictionary["followers_url"] as? String,
                let gists_url = itemDictionary["gists_url"] as? String,
                let starred_url = itemDictionary["starred_url"] as? String,
                let subscriptions_url = itemDictionary["subscriptions_url"] as? String,
                let organizations_url = itemDictionary["organizations_url"] as? String,
                let repos_url = itemDictionary["repos_url"] as? String,
                let events_url = itemDictionary["events_url"] as? String,
                let received_events_url = itemDictionary["received_events_url"] as? String,
                let type = itemDictionary["type"] as? String,
                let site_admin = itemDictionary["site_admin"] as? Bool,
                let score = itemDictionary["site_admin"] as? Double {
                self.searchedItems.append(SearchedItem(login: login, git_id: git_id, node_id: node_id, avatar_url: avatar_url, gravatar_id: gravatar_id, url: url, html_url: html_url, followers_url: followers_url, gists_url: gists_url, starred_url: starred_url, subscriptions_url: subscriptions_url, organizations_url: organizations_url, repos_url: repos_url, events_url: events_url, received_events_url: received_events_url, type: type, site_admin: site_admin, score: score))
            }
            
        }
    }
}
