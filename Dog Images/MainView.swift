//
//  MainView.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var imageList: FavoriteImageList
    
    var body: some View {
        
        TabView {
            
            HomeView(favoriteImageList: imageList)
                .tabItem({
                    Image(systemName: "house")
                    Text("Home")
                })
            
            FavoriteView(favoriteImageList: imageList)
                .tabItem({
                    Image(systemName: "star")
                    Text("Favorites")
                })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(imageList: FavoriteImageList())
    }
}
