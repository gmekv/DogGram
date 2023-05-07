//
//  OnboardingViewPart2.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 06.05.23.
//
import SwiftUI

struct OnboardingViewPart2: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var displayName: String = ""
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
        
    }
    
    // MARK: FUNCTIONS
    
    func createProfile() {
        print("CREATE PROFILE NOW")
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
    static var previews: some View {
        OnboardingViewPart2()
            
    }
}


