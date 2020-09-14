//
//  DogImage.swift
//  Dog Images
//
//  Created by Sajan Shrestha on 7/10/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import Foundation

struct DogImage: Identifiable, Codable {
    
    var id = UUID().uuidString
    
    var imageData: Data
    
    var memeText: String?
    
    var isFavorite = false
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    mutating func setFavorite(to favorite: Bool) {
        isFavorite = favorite
    }
}

extension DogImage {
    
    init?(json: Data?) {
        if json != nil, let favoriteImage = try? JSONDecoder().decode(DogImage.self, from: json!) {
            self = favoriteImage
        } else {
            return nil
        }
    }
}
