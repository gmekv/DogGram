//
//  ContentView.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 03.05.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                FeedView(posts: PostArrayObject(), title: "Feed") }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
            NavigationView {
                BrowseView()

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
            Text("Screen 2")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Browse")
                }
        }
        .accentColor(Color.MyTheme.purpleColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}