//
//  PostModel.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 03.05.23.
//

import Foundation
import SwiftUI

struct PostModel: Identifiable, Hashable {
    
    var id = UUID() // ID for post in Database
    var postID: String // Id for post in Database
    var userID: String // ID for user in Database
    var username: String // Username of user in Database
    var caption: String?
    var dateCreated: Date
    var likeCount: Int
    var likedByUser: Bool
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //postID
    //userID
    //user username
    //caption - optional
    // date
    //like count
    // liked by current user
}
