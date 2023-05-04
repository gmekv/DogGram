//
//  CommentsView.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 03.05.23.
//

import SwiftUI

struct CommentsView: View {
    @State var submissionText: String = ""
    @State var commentArray = [CommentModel]()
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(commentArray, id: \.self) { comment in
                        MessageView(comment: comment)
                    }
                }

            }
            
            HStack {
                Image("dog1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                TextField("Add a coment here", text: $submissionText)
                Button {
                    
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)                }
                .accentColor(Color.MyTheme.purpleColor)
                
                
            }
            .padding(.all, 6)
        }
        .navigationBarTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            getComments()
        }
    }
    func getComments() {
        print(" get comments from database")
        let comment1 = CommentModel(commentID: "", userID: "", username: "Joe Green", content: "First comment", dateCreated: Date())
        let comment2 = CommentModel(commentID: "", userID: "", username: "Joe Green", content: "Second comment", dateCreated: Date())
        let comment3 = CommentModel(commentID: "", userID: "", username: "Joe Green", content: "Third comment", dateCreated: Date())
        let comment4 = CommentModel(commentID: "", userID: "", username: "Joe Green", content: "Fourth comment", dateCreated: Date())
        self.commentArray.append(comment1)
        self.commentArray.append(comment2)
        self.commentArray.append(comment3)
        self.commentArray.append(comment4)

    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommentsView()
        }
    }
}
