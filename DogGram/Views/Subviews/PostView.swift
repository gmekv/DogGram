//
//  PostView.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 03.05.23.
//

import SwiftUI

struct PostView: View {
    
    
    @State var post: PostModel
    var showHeaderandFooter: Bool
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            //Mark header
            if showHeaderandFooter {
                HStack {
                    Image("dog1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30, alignment: .center)
                        .cornerRadius(15)
                    Text(post.username)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "ellipsis")
                        .font(.headline)
                }
                .padding(.all, 5)
                
            }

            //Mark image
            
            Image("dog1")
                .resizable()
                .scaledToFit()
            
            if showHeaderandFooter {
                HStack(alignment: .center, spacing: 20, content:  {
                    Image(systemName: "heart")
                        .font(.title3)
                    //Mark: Comment Icon
                    NavigationLink {
                       CommentsView()
                    } label: {
                        Image(systemName: "bubble.middle.bottom")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    Image(systemName: "paperplane")
                        .font(.title3)
                    Spacer()
                    
                })
                .padding(.all, 5)
                if let caption = post.caption {
                    HStack {
                        Text(caption)
                        Spacer(minLength: 0)
                    }
                    .padding(.all, 6)
                }}
            
            //        Mark: footer
        }}
}

struct PostView_Previews: PreviewProvider {
    static var post: PostModel = PostModel(postID: "", userID: "", username: "Joe Green", caption:"test", dateCreated: Date(), likeCount: 0, likedByUser: false)
    static var previews: some View {
        PostView(post: post, showHeaderandFooter: true)
            .previewLayout(.sizeThatFits)
    }
}
