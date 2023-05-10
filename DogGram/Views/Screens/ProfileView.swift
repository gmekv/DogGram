//
//  ProfileView.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 05.05.23.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var isMyprofile: Bool
    @State var profileDisplayName: String
    var profileUserID: String
    
    var posts = PostArrayObject()
    
    
    @State var showSettings: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            ProfileHeaderView(profileDisplayName: $profileDisplayName)
            Divider()
            ImageGridView(posts: posts)
        })
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: Button(action: {
                // Action for leading button
                showSettings.toggle()
            }, label: {
                Image(systemName: "line.horizontal.3")
            })
            .accentColor(Color.MyTheme.purpleColor)
            .opacity( isMyprofile ? 1.0 : 0.0)
        )
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
                .preferredColorScheme(colorScheme)
        })
    }}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(isMyprofile: true, profileDisplayName: "Joe", profileUserID: "")

        }
    }
}
