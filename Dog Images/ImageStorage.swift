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
    static private let imageFolderName = "Images"
    
    static var imageFolderUrl: URL? {
        do {
            let fileUrl = try filemanager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(imageFolderName)
            return fileUrl
            
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
      
    static func add(_ dogImage: DogImage) {
        
        save(dogImage.image, with: dogImage.id)
    }
    
    static private func save(_ image: UIImage, with name: String) {
        
        guard let folderUrl = imageFolderUrl else { return }
        
        let fileUrl = folderUrl.appendingPathComponent(name)
        
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        
        do {
            
            try data.write(to: fileUrl)
        }
        catch {
            
            print(error.localizedDescription)
        }
    }
    
    static func getImages() -> [DogImage]?  {
        
        guard let folderUrl = imageFolderUrl else { return nil }
        
        var dogImages = [DogImage]()
        
        do {
            let contents = try filemanager.contentsOfDirectory(atPath: folderUrl.path)
            
            contents.forEach { file in
                
                do {
                    
                    let data = try Data(contentsOf: folderUrl.appendingPathComponent(file))
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
        
        guard let folderUrl = imageFolderUrl else { return }
        
        let fileUrl = folderUrl.appendingPathComponent(imageName)
        
        do {
            try filemanager.removeItem(at: fileUrl)
        }
        
        catch {
            print(error.localizedDescription)
        }
    }
    
}
