//
//  CommentModel.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 04.05.23.
//

import Foundation
import SwiftUI
struct CommentModel: Identifiable, Hashable {
    var id = UUID()
    var commentID: String // ID for comment in the DATABASE
    var userID: String // ID for the user in DATABASE
    var username: String // Username for the user in the DATABASe
    var content: String // Actually comment text
    var dateCreated: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
