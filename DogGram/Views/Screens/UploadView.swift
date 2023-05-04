//
//  UploadView.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 04.05.23.
//
import UIKit
import SwiftUI

struct UploadView: View {
    var body: some View {
        ZStack {
            VStack {
                Button {
                    // take photo action
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
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 12)
        }
        .edgesIgnoringSafeArea(.top)
    }}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
