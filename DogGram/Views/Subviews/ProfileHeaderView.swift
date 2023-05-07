//
//  ProfileHeaderView.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 05.05.23.
//

import SwiftUI

struct ProfileHeaderView: View {
    @Binding var profileDisplayName: String
    
    var body: some View {
//Mark profile picutre
        VStack(alignment: .center, spacing: 10, content: {
            Image("dog1")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120, alignment: .center)
                .cornerRadius(60)
            // Mark User Name
            Text(profileDisplayName)
                .font(.largeTitle)
                .fontWeight(.bold)
            // mark Bio
            Text("Bio text")
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
            
            HStack(alignment: .center, spacing: 20, content: {
                //Mark Posts
                VStack(alignment: .center,  spacing: 5, content: {
                    Text("5")
                        .font(.title2)
                        .fontWeight(.bold)
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    Text("Posts")
                        .font(.callout)
                        .fontWeight(.medium)
                })
                VStack(alignment: .center,  spacing: 5, content: {
                    Text("20")
                        .font(.title2)
                        .fontWeight(.bold)
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    Text("Likes")
                        .font(.callout)
                        .fontWeight(.medium)
                })
                
            })
        }  )
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    @State static var name: String = "Joe"
    static var previews: some View {
        ProfileHeaderView(profileDisplayName: $name)
    }
}
