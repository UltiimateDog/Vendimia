//
//  Profile.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 28/02/24.
//

import Foundation
import SwiftUI

// Creates the struct for the profile
struct Profile {
    var username: String
    var profilePic: UIImage
    
    var currentPoints: Int
    var goalPoints: Int
    
    static let `default` = Profile(username: "Goben Diego Constantino Aguirre")
    
    init(username: String) {
        self.username = username
        profilePic = UIImage(imageLiteralResourceName: "IMG_2989")

        currentPoints = 120
        goalPoints = 10_000
    }

}
