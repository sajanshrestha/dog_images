//
//  DogImageList.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/9/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import Foundation

struct DogImageList {
    
    var images = [DogImage]()
    
    init() {
        guard let receivedmages = ImageStorage.getImages() else { return }
        images = receivedmages
    }
    
    mutating func addFavoriteImage(_ image: DogImage) {
        images.append(image)
        ImageStorage.add(image)
    }
    
    mutating func removeFavoriteImage(_ image: DogImage) {
        guard let index = images.firstIndex(matching: image) else { return }
        images.remove(at: index)
        ImageStorage.removeImage(imageName: image.id)
    }
}
