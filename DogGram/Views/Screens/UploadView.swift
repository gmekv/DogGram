//
//  UploadView.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 04.05.23.
//
import UIKit
import SwiftUI

struct UploadView: View {
    
    @State var showImagePicker: Bool = false
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var showPostImageView: Bool = false
    var body: some View {
        ZStack {
            VStack {
                Button {
                    sourceType = UIImagePickerController.SourceType.camera
                    showImagePicker.toggle()
                } label: {
                    Text("Take Photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.yellowColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.MyTheme.purpleColor)
                
                Spacer() // add a spacer here
                
                Button {
                    sourceType = UIImagePickerController.SourceType.photoLibrary
                    showImagePicker.toggle()

                    // import photo action
                } label: {
                    Text("Import Photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.purpleColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.MyTheme.yellowColor)
            }
            .sheet(isPresented: $showImagePicker, onDismiss: segueToPostImageView, content: {
                ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
            })
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 12)
                .fullScreenCover(isPresented: $showPostImageView, content:  {
                    PostImageView(imageSelected: $imageSelected)
                })
        }
        .edgesIgnoringSafeArea(.top)
    }
    func segueToPostImageView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showPostImageView.toggle()
        }
    }
    
    
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
