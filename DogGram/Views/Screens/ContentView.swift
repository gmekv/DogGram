//
//  ContentView.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 03.05.23.
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentUserDisplayName: String?

    let feedPosts = PostArrayObject(shuffled: false)
    let browsePosts = PostArrayObject(shuffled: true)

    var body: some View {
        Group {
            if let userID = currentUserID, let displayName = currentUserDisplayName {
                MainContentView(userID: userID, displayName: displayName, feedPosts: feedPosts, browsePosts: browsePosts)
            } else {
                SignUpView()
            }
        }
        .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
    }
}

struct MainContentView: View {
    let userID: String
    let displayName: String
    let feedPosts: PostArrayObject
    let browsePosts: PostArrayObject

    var body: some View {
        TabView {
            NavigationView {
                FeedView(posts: feedPosts, title: "Feed")
            }
            .tabItem {
                Image(systemName: "book.fill")
                Text("Feed")
            }

            NavigationView {
                BrowseView(posts: browsePosts)
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Browse")
            }

            UploadView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Upload")
                }

            NavigationView {
                ProfileView(isMyProfile: true, profileDisplayName: displayName, profileUserID: userID, posts: PostArrayObject(userID: userID))
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
    }
}
