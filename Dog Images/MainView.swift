//
//  MainView.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var imageList: DogImageModel
    
    var body: some View {
        
        TabView {
            
            HomeView(imageModel: imageList)
                .tabItem({
                    Image(systemName: "house")
                    Text("Home")
                })
            
            FavoriteView(imageList: imageList)
                .tabItem({
                    Image(systemName: "star")
                    Text("Favorites")
                })
            
            MemesView(imageList: imageList)
            .tabItem({
                Image(systemName: "cloud")
                Text("Memes")
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(imageList: DogImageModel())
    }
}
