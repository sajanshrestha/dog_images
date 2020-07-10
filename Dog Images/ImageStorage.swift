//
//  ImageStorage.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit


struct ImageStorage {
    
    static let filemanager = FileManager.default
      
    static func add(_ dogImage: DogImage) {
        
        save(dogImage.image, with: dogImage.id)
    }
    
    static private func save(_ image: UIImage, with name: String) {
        
        do {
                        
            let fileUrl = try filemanager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(name)
                                    
            guard let data = image.jpegData(compressionQuality: 0.8) else { return }
            
            try data.write(to: fileUrl)
            
        }
        catch {
            
            print(error.localizedDescription)
        }
    }
    
    static func getImages() -> [DogImage]?  {
        
        do {
            
            let fileUrl = try filemanager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            var dogImages = [DogImage]()
            
            let contents = try filemanager.contentsOfDirectory(atPath: fileUrl.path)
            
            contents.forEach { file in
                
                do {
                    let data = try Data(contentsOf: fileUrl.appendingPathComponent(file))
                    guard let image = UIImage(data: data) else { return }
                    dogImages.append(DogImage(id: file, image: image))
                    
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            
            return dogImages
            
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func removeImage(imageName: String) {
        
        do {
            let fileUrl = try filemanager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(imageName)
            try filemanager.removeItem(at: fileUrl)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}
