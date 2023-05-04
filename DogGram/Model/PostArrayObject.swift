//
//  PostArrayObject.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 03.05.23.
//

import Foundation
class PostArrayObject: ObservableObject {
    @Published var dataArray = [PostModel]()
    
    init() {
        print("Fetch from Database here")
        let post1 = PostModel(postID: "", userID: "", username: "Joe Greene", caption: "This is a caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post2 = PostModel(postID: "", userID: "", username: "Joe Greene", caption: "This is a caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post3 = PostModel(postID: "", userID: "", username: "Emily", caption: "This is a caption but a very very long hahahahah", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post4 = PostModel(postID: "", userID: "", username: "Christopher", caption: "This is a caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        self.dataArray.append(post1)
        self.dataArray.append(post2)
        self.dataArray.append(post3)
        self.dataArray.append(post4)

    }
    //Used for single post selection
    init(post: PostModel) {
        self.dataArray.append(post)
    }
}
