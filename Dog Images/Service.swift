//
//  Service.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit

struct Service {
    
    static let session = URLSession.shared
        
    enum EndPoint {
        
        case randomDogImage
        case randomBreedImage(breed: String)
        case breedList
        
        var url: URL {
            
            switch self {
                
            case .randomDogImage:
                return URL(string: "https://dog.ceo/api/breeds/image/random")!
                
            case .randomBreedImage(let breed):
                return URL(string: "https://dog.ceo/api/breed/\(breed)/images/random")!
                
            case .breedList:
                return URL(string: "https://dog.ceo/api/breeds/list/all")!
            }
        }
    }
        
    static func getRandomDogImage(for breed: String, completion: @escaping (UIImage) -> Void) {
        
        if breed == "random" {
            
            getImage(with: EndPoint.randomDogImage.url) { image in
                completion(image)
            }
        }
            
        else {
            
            getImage(with: EndPoint.randomBreedImage(breed: breed).url) { image in
                completion(image)
            }
        }
    }
    
    static private func getResponse(with url: URL, completion: @escaping (Response) -> Void) {
                
        let task = session.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            guard let response = JSONDecoder.decode(Response.self, from: data) else { return }
            
            completion(response)
            
        }
        task.resume()
        
    }
    
    static func getImage(with url: URL, completion: @escaping (UIImage) -> Void) {
        
        getResponse(with: url) { response in
            
            guard let imageUrl = URL(string: response.message) else { return }
            
            let task = session.dataTask(with: imageUrl) { (data, _, _) in
                
                guard let data = data else { return }
                
                guard let image = UIImage(data: data) else { return }
                
                completion(image)
                
            }
            
            task.resume()
        }
    }
    
    static func getBreedList(completion: @escaping ([String]) -> Void) {
        
        let task = session.dataTask(with: EndPoint.breedList.url) { (data, _, _) in
            
            guard let data = data else { return }
            
            guard let response = JSONDecoder.decode(ListResponse.self, from: data) else { return }
                 
            let message = response.message
                
            let breeds = message.map { $0.key }
                
            completion(breeds)
            
        }
        
        task.resume()
    }
}
