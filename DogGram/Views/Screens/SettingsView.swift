//
//  SettingsView.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 05.05.23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content:  {
                //Mark Section1. Dogram
                GroupBox(label: SettingsLabelView(labelText: "DogGram", labelImage: "dot.radiowaves.left.and.right"), content: {
 
                    HStack(alignment: .center, spacing: 40, content:  {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(12)
                        Text("DogGram is #1 app for dog-lovers community. Happy to see you here")
                            .font(.footnote)
                    })
                })
                .padding()
                // Mark 2 Profile
                GroupBox(label: SettingsLabelView(labelText: "Profile", labelImage: "person.fill"), content: {
                    
                    NavigationLink(
                        destination: SettingsEditTextView(submissionText: "Current display name", title: "Display Name", description: "You can edit your display name here. This will be seen by other users on your profile and on your posts!", placeholder: "Your display name here..."),
                        label: {
                            SettingsRowView(leftIcon: "pencil", text: "Display Name", color: Color.MyTheme.purpleColor)
                        })
                    
                    NavigationLink(
                        destination: SettingsEditTextView(submissionText: "Current bio here", title: "Profile Bio", description: "Your bio is a great place to let other users know a little about you. It will be shown on your profile only.", placeholder: "Your bio here.."),
                        label: {
                            SettingsRowView(leftIcon: "text.quote", text: "Bio", color: Color.MyTheme.purpleColor)
                        })
                    
                    NavigationLink(
                        destination: SettingsEditImageView(title: "Profile Picture", description: "Your profile picture will be shown on your profile and on your posts. Most users make it an image of themselves or of their dog!", selectedImage: UIImage(named: "dog1")!),
                        label: {
                            SettingsRowView(leftIcon: "photo", text: "Profile Picture", color: Color.MyTheme.purpleColor)
                        })
                    
                    SettingsRowView(leftIcon: "figure.walk", text: "Sign out", color: Color.MyTheme.purpleColor)

                    
                })
                .padding()
                
                
       
                
                // MARK: SECTION 3: SIGN OFF
                GroupBox {
                    Text("DogGram was made with love by Giorgi following Nicks tutorial. \n All Rights Reserved \n Cool Apps Inc. \n Copyright 2023 ♥️")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    
                }
                .padding()
                .padding(.bottom, 80)
                
            })
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .font(.title)
                                    })
                                    .accentColor(.primary)
            )
        }
        .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)

    }
    
    

    
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
