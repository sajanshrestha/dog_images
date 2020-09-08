//
//  FavView.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var favoriteImageList: FavoriteImageList
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(favoriteImageList.images) { image in
                    
                    NavigationLink(destination: DetailView(image: image, imageList: self.favoriteImageList), label: {
                        Image(uiImage: image.image)
                            .resizable()
                            .frame(height: self.height)
                            .cornerRadius(self.cornerRadius)
                    })
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Favorites (\(favoriteImageList.images.count))"))
        }
    }
    
    // MARK:- CONSTANTS
    private let height: CGFloat = 300
    private let cornerRadius: CGFloat = 8
}

struct FavView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(favoriteImageList: FavoriteImageList())
    }
}
