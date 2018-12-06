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
    
    func getSearchResults(searchedTerm: String, completion: @escaping QueryResult)
    
}
