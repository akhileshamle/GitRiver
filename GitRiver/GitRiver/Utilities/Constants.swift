//  Constants.swift
//  GitRiver
//  Created by Akhilesh Amle on 06/12/18.
//  Copyright © 2018 AkhileshAmle. All rights reserved.

import UIKit

struct Constants {
    
    // MARK: - Strings
    struct Strings {
        static let appName = "Git River"
        
        // Alert Strings
        struct AlertAction {
            static let ok = "Ok"
            static let cancel = "Cancel"
        }
        struct AlertMessage {
            static let noConnection = "Couldn't connect to the network."
        }
        
        // Storyboard Identifiers
        struct StoryboardIdentifier {
            static let main = "Main"
        }
        
        // View Controller Identifiers
        struct ViewControllerIdentifier {
            static let gtrHomeViewController = "GTRHomeViewController"
        }
        
        // API Path
        struct APIPath {
            static let baseURL = "https://api.github.com/"
            
            // Search User
            static let getSearchedUser = baseURL + "search/users?q="
        }
        
    }
    
    // MARK: - Colors
    struct Color {
        
    }
}
