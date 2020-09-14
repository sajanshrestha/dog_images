//
//  ImageStorage.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit

struct DataStorage {
    
    static let folderName = "Json Folder"
    
    static let filemanager = FileManager.default
    
    static func save(_ json: Data, withId id: String) {
        
        let folderUrl = getFolderUrl()
        
        guard let jsonFileUrl = folderUrl?.appendingPathComponent(id) else { return }
        do {
            try json.write(to: jsonFileUrl)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
    static func removeData(id: String) {
        
        guard let folderUrl = getFolderUrl() else { return }
        
        let fileUrl = folderUrl.appendingPathComponent(id)
        
        do {
            try filemanager.removeItem(at: fileUrl)
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    
    private static func getFolderUrl() -> URL? {
        
        let folderName = DataStorage.folderName
        
        do {
            var folderUrl = try filemanager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            folderUrl.appendPathComponent(folderName)
            try filemanager.createDirectory(at: folderUrl, withIntermediateDirectories: true, attributes: nil)
            return folderUrl
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func getAllData() -> [Data] {
        
        guard let folderUrl = getFolderUrl() else { return [] }
        
        var dataCollection = [Data]()
        
        do {
            let contents = try filemanager.contentsOfDirectory(atPath: folderUrl.path)
            
            contents.forEach { file in
                
                do {
                    
                    let data = try Data(contentsOf: folderUrl.appendingPathComponent(file))
                    dataCollection.append(data)
                    
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            
            return dataCollection
        }
        catch {
            
            print(error.localizedDescription)
            return []
        }
    }
}
