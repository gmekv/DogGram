//
//  PostView.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 03.05.23.
//

import SwiftUI
import UIKit

struct PostView: View {
    
    
    @State var post: PostModel
    var showHeaderandFooter: Bool
    @State var postImage: UIImage = UIImage(named: "dog1")!
     
    @State var animatedLIke: Bool = false
    @State var showActionSheet: Bool = false
    @State var actionSheeType: PostActionSheetOption = .general
    
    enum PostActionSheetOption {
        case general
        case reposting
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            //Mark header
            if showHeaderandFooter {
                HStack {
                    NavigationLink(
                        destination: ProfileView(isMyprofile: false, profileDisplayName: post.username, profileUserID: post.userID),
                     label: {
                         Image(uiImage: postImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30, alignment: .center)
                            .cornerRadius(15)
                        Text(post.username)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    })

                 
                    Spacer()
                    Button {
                        showActionSheet.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.headline)
                    }
                    .accentColor(.primary)
                    .actionSheet(isPresented: $showActionSheet) {
                 getActionSheet()
                    }



                }
                .padding(.all, 5)
                
            }

            //Mark image
            
                Image("dog1")
                    .resizable()
                    .scaledToFit()
            
            //Mark:  Footer
            
            if showHeaderandFooter {
                HStack(alignment: .center, spacing: 20, content:  {
                    Button(action: {
                        if post.likedByUser {
                            // Unlike the post
                            unlikepost()
                        } else {
                            // like
                            likepost()
                        }
                    },
                           label: {
                        Image(systemName: post.likedByUser ? "heart.fill" : "heart")
                            .font(.title3)

                    })

                    // Add .foregroundColor here
                    .foregroundColor(post.likedByUser ? .red : .primary)


                    //Mark: Comment Icon
                    NavigationLink {
                        CommentsView()
                    } label: {
                        Image(systemName: "bubble.middle.bottom")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    Button {
                        sharePost()
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.title3)}
                    .accentColor(.primary)
            
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
            
        }}
    func likepost() {
        let updatedPost = PostModel(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreated: post.dateCreated, likeCount: post.likeCount, likedByUser: true)
        self.post = updatedPost
        animatedLIke = true
        
        // Trigger haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            animatedLIke
            = false
        }
    }

    func unlikepost() {
        let updatedPost = PostModel(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreated: post.dateCreated, likeCount: post.likeCount, likedByUser: false)
        self.post = updatedPost
        
        // Trigger haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    func getActionSheet() -> ActionSheet {
           switch self.actionSheeType {
           case .general:
               return ActionSheet(title: Text("What would you like to do?"), message: nil, buttons: [
                   .destructive(Text("Report"), action: {
                       
                       self.actionSheeType = .reposting
                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                           self.showActionSheet.toggle()
                       }
                       
                   }),
                   
                   .default(Text("Learn more..."), action: {
                       print("LEARN MORE PRESSED")
                   }),
                   
                   .cancel()
               ])
        case .reposting:
            return ActionSheet(
                title: Text("Why are you reporting this post"),
                message: nil,
                buttons: [
                    .destructive(Text("This is inappropriate"), action: {
                        reportPost(reason: "This is inappropriate")
                    }),
                    .destructive(Text("This is spam"), action: {
                        reportPost(reason: "This is spam")
                    }),
                    .destructive(Text("It made me uncomfortable"), action: {
                        reportPost(reason: "It made me uncomfortable")
                    }),
                    .cancel({
                        self.actionSheeType = .general        })])}}

    func reportPost(reason: String) {
        print("report post now")
    }
    func sharePost() {
        let message = "Check out this post on DogGram"
        let image = postImage
        let activityViewController = UIActivityViewController(activityItems: [message, image,], applicationActivities: nil)
        let viewController = UIApplication.shared.windows.first?.rootViewController
        viewController?.present(activityViewController, animated: true, completion: nil)
    }
    
}

struct PostView_Previews: PreviewProvider {
    static var post: PostModel = PostModel(postID: "", userID: "", username: "Joe Green", caption:"test", dateCreated: Date(), likeCount: 0, likedByUser: false)
    static var previews: some View {
        PostView(post: post, showHeaderandFooter: true)
            .previewLayout(.sizeThatFits)
    }
}
