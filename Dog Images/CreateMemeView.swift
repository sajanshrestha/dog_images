//
//  CreateMemeView.swift
//  Dog Images
//
//  Created by Sajan Shrestha on 9/10/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct CreateMemeView: View {
    
    var image: UIImage
    
    @State private var memeText = ""
    
    var imageList: DogImageModel
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            ZStack(alignment: .top) {
                
                Image(uiImage: image)
                    .resizable()
                
                TextField("", text: $memeText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .offset(x: 0, y: 20)
                    .padding()
            }
            
            Button("Save Meme") {
                
                let memeImage = DogImage(imageData: self.image.pngData()!, memeText: self.memeText)
                self.imageList.addDogImage(memeImage)
                
                self.presentation.wrappedValue.dismiss()
            }
            
            Button("Cancel") {
                
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}
