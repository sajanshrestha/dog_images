//
//  DetailView.swift
//  Dog Images
//
//  Created by Sajan Shrestha on 7/10/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    var image: DogImage
    
    @State private var zoomed = false
    
    @State private var addedToList = true
    
    @ObservedObject var imageList: DogImageModel
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Image(uiImage: UIImage(data: image.imageData)!)
                .resizable()
                .aspectRatio(contentMode: zoomed ? .fill : .fit)
            
            Text(image.memeText ?? "")
                .font(Font.custom("menlo", size: 30))
                .background(Color.white.opacity(0.5).frame(width: UIScreen.main.bounds.width))
                .padding()
                .offset(y: -20)
            
        }
            .navigationBarItems(
                trailing:
                HeartImage(addedToList: $addedToList) {
                    self.toggleListPresence()
            })
            .onTapGesture(count: 2) {
                withAnimation {
                    self.zoomed.toggle()
                }
        }
    }
    
    private func toggleListPresence() {
        
        if addedToList {
            imageList.removeDogImage(image)
            self.addedToList = false
        }
        else {
            imageList.addDogImage(image)
            self.addedToList = true
        }
    }
}
