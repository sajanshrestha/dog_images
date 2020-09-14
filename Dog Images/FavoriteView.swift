//
//  FavView.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var imageList: DogImageModel
    
    var body: some View {
        
        let favoriteImages = imageList.dogImages.filter { $0.isFavorite == true }
        
        return NavigationView {
            
            List {
                
                ForEach(favoriteImages) { image in
                    
                    NavigationLink(destination: DetailView(image: image, imageList: self.imageList), label: {
                        
                        Image(uiImage: UIImage(data: image.imageData)!)
                            .resizable()
                            .frame(height: self.height)
                            .cornerRadius(self.cornerRadius)
                    })
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Favorites (\(favoriteImages.count))"))
        }
    }
    
    // MARK:- CONSTANTS
    private let height: CGFloat = 300
    private let cornerRadius: CGFloat = 8
}

struct FavView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(imageList: DogImageModel())
    }
}
