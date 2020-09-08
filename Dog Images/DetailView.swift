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
    
    @State private var favoriteItem = true
    
    @ObservedObject var imageList: FavoriteImageList
    
    var body: some View {
        
        Image(uiImage: image.image)
            .resizable()
            .aspectRatio(contentMode: zoomed ? .fill : .fit)
            .navigationBarItems(
                trailing:
                HeartImage(favorite: $favoriteItem) {
                    self.toggleFavorite()
            })
            .onTapGesture(count: 2) {
                withAnimation {
                    self.zoomed.toggle()
                }
        }
    }
    
    private func toggleFavorite() {
        
        if favoriteItem {
            imageList.removeFavoriteImage(image)
            self.favoriteItem = false
        }
        else {
            imageList.addFavoriteImage(image)
            self.favoriteItem = true
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(image: DogImage(image: UIImage()), imageList: FavoriteImageList())
    }
}
