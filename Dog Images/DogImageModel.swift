//
//  FavoriteDogModel.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/9/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit

class DogImageModel: ObservableObject {
    
    @Published private(set) var dogImages = [DogImage]()
    @Published private(set) var displayedImage: UIImage?

    init() {
        fetchImages()
        setDisplayedImage()
    }
    
    private func fetchImages() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let receivedData = DataStorage.getAllData()
                    
            for data in receivedData {
                
                if let image = DogImage(json: data) {
                    
                    DispatchQueue.main.async {
                        
                        self.dogImages.append(image)
                    }
                }
            }
        }
    }
    
    private func setDisplayedImage() {
        
        Service.getRandomDogImage(for: "random") { image in
            self.displayedImage = image
        }
    }
    
    func addDogImage(_ dogImage: DogImage) {
        dogImages.append(dogImage)
        DataStorage.save(dogImage.json!, withId: dogImage.id)
    }
    
    func removeDogImage(_ dogImage: DogImage) {
        guard let index = dogImages.firstIndex(matching: dogImage) else { return }
        dogImages.remove(at: index)
        DataStorage.removeData(id: dogImage.id)
    }
    
    func setRandomImage(for breed: String) {
        
        Service.getRandomDogImage(for: breed) { image in
            self.displayedImage = image
        }
    }

}

