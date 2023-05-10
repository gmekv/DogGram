//
//  OnboardingViewPart2.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 06.05.23.
//
import SwiftUI

struct OnboardingViewPart2: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @Binding var displayName: String
    @Binding var email: String
    @Binding var providerID: String
    @Binding var provider: String
    @State var showError: Bool = false
    @State var showImagePicker: Bool = false
    
    // For image picker
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            
            Text("What's your name?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.MyTheme.yellowColor)
            
            TextField("Add your name here...", text: $displayName)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.beigeColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
                .padding(.horizontal)
            
            Button(action: {
                showImagePicker.toggle()
            }, label: {
                Text("Finish: Add profile picture")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.yellowColor)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .foregroundColor(.clear)

            })
            .accentColor(Color.MyTheme.purpleColor)
            .opacity(displayName != "" ? 1.0 : 0.0)
            /// FIX!!!!! 
            .animation(.easeOut(duration: 1.0))
            
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.purpleColor)
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showImagePicker, onDismiss: createProfile, content: {
            ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
        })
        .alert(isPresented: $showError) {
            () -> Alert in return Alert(title: Text("Error Creating profile"))
        }
    }
    
    // MARK: FUNCTIONS
    
    func createProfile() {
        print("CREATE PROFILE NOW")
        AuthService.instance.CreateNewUserInDatabase(name: displayName, email: email, providerID: providerID, provider: provider, profileImage: imageSelected) { (returnedUserID) in
            if let userID = returnedUserID {
                //success
                print("Sucessfully created new user into a database ")
                AuthService.instance.logInUserToApp(userID: userID) { success in
                    if success {
                        print("User logged in!")
                        
                        //return to app
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            self.presentationMode.wrappedValue.dismiss()
                        })
                        self.presentationMode.wrappedValue.dismiss()
                        
                    } else {
                        print("Error logging in")
                        self.showError.toggle()
                    }}
                
            } else {
                //ERROR
                print("Error in database")
                
            }
        }
    }
    struct HapticFeedback: UIViewRepresentable {
        typealias UIViewType = UIView

        func makeUIView(context: Context) -> UIView {
            return UIView()
        }

        func updateUIView(_ uiView: UIView, context: Context) {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
    
}

struct OnboardingViewPart2_Previews: PreviewProvider {
    @State static var teststring: String = "Test"
    static var previews: some View {
        OnboardingViewPart2(displayName: $teststring, email: $teststring, providerID: $teststring, provider: $teststring)
            
    }
}


