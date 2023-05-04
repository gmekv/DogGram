//
//  ImageGrid.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 04.05.23.
//

import SwiftUI

struct ImageGridView: View {
    @ObservedObject var posts: PostArrayObject
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], alignment: .center, spacing: nil, pinnedViews: []) {
            
            ForEach(posts.dataArray, id: \.self) { post in
                NavigationLink(
                    destination: FeedView(posts: PostArrayObject(post: post), title: "Post"),
                    label: { PostView(post: post, showHeaderandFooter: false) }
                )
            }

      

        }
    }}

struct ImageGrid_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(posts: PostArrayObject())
            .previewLayout(.sizeThatFits)
    }
}