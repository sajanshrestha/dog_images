//
//  FavoriteDogModel.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/9/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit

class ImageList: ObservableObject {
    
    @Published private(set) var favoriteImages = [FavoriteImage]()
    
    init() {
        favoriteImages = fetchImages()
    }
    
    func addFavoriteImage(_ favoriteImage: FavoriteImage) {
        favoriteImages.append(favoriteImage)
        DataStorage.save(favoriteImage.json!, withId: favoriteImage.id)
    }
    
    func removeFavoriteImage(_ favoriteImage: FavoriteImage) {
        guard let index = favoriteImages.firstIndex(matching: favoriteImage) else { return }
        favoriteImages.remove(at: index)
        DataStorage.removeData(id: favoriteImage.id)
    }
    
    private func fetchImages() -> [FavoriteImage] {
        
        let receivedData = DataStorage.getAllData()
        
        var images = [FavoriteImage]()
        
        for data in receivedData {
            
            if let image = FavoriteImage(json: data), image.id.hasPrefix(FavoriteImage.FavoriteImagePrefix) {
                images.append(image)
            }
        }
        
        return images
    }
}

