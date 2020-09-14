//
//  MemesView.swift
//  Dog Images
//
//  Created by Sajan Shrestha on 9/10/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct MemesView: View {
    
    @ObservedObject var imageList: DogImageModel

    var body: some View {
        
        let memeImages = imageList.dogImages.filter { $0.memeText != nil }
        
        return NavigationView {
            
            List {
                
                ForEach(memeImages) { image in
                    
                    NavigationLink(destination: DetailView(image: image, imageList: self.imageList), label: {
                        
                        MemeImageView(memeText: image.memeText ?? "", image: UIImage(data: image.imageData)!)
                        
                    })
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Memes (\(memeImages.count))"))
        }
    }
}




struct MemeImageView: View {
    
    var memeText: String
    var image: UIImage
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Image(uiImage: image)
                .resizable()
                .frame(height: self.height)
                .cornerRadius(self.cornerRadius)
            Text(memeText)
                .font(Font.custom("menlo", size: 30))
                .padding()
                .background(Color.white.opacity(0.5).cornerRadius(8.0))
                .offset(y: 20)
            
        
        }
    }
    
    // MARK:- CONSTANTS
    private let height: CGFloat = 300
    private let cornerRadius: CGFloat = 8
}
