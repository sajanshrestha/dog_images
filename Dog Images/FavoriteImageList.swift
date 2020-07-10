//
//  FavoriteDogModel.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/9/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit

class FavoriteImageList: ObservableObject {
    
    @Published private var imageList = DogImageList()
    
    var images: [DogImage] {
        imageList.images
    }
    
    func addFavoriteImage(_ dogImage: DogImage) {
        imageList.addFavoriteImage(dogImage)
    }
    
    func removeFavoriteImage(_ dogImage: DogImage) {
        imageList.removeFavoriteImage(dogImage)
    }
}

