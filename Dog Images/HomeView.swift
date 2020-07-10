//
//  ContentView.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State private var image = UIImage()
    @State private var favoriteImage = false
    @State private var selectedBreed = 0
    @State private var breeds = ["random"]
    
    @ObservedObject var imageList: FavoriteImageList
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Form {
                    Picker("Breed", selection: $selectedBreed) {
                        ForEach(0..<breeds.count, id: \.self) { index in
                            Text(self.breeds[index])
                        }
                    }
                }
                .frame(height: 50)
                .onAppear {
                    self.setImage()
                }
                
                ZStack(alignment: .bottom) {
                    
                    Image(uiImage: image)
                        .resizable()
                    
                    HStack {
                        HeartImage(favorite: $favoriteImage) {
                            self.setImageAsFavorite()
                        }
                        .padding()
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .background(Color.white.opacity(backgroundOpacity))
                    
                }
                
            }
            .navigationBarItems(
                trailing: Button(action: {
                    self.setImage()
                }, label: {
                    Text("Next")
                }))
                .onAppear {
                    Service.getBreedList { breeds in
                        DispatchQueue.main.async {
                            self.breeds.append(contentsOf: breeds)
                        }
                    }
            }
        }
    }
    
    private func setImage() {
        Service.getRandomDogImage(for: breeds[selectedBreed]) { image in
            DispatchQueue.main.async {
                withAnimation(Animation.spring()) {
                    self.image = image
                }
            }
        }
        self.favoriteImage = false
    }
    
    private func setImageAsFavorite() {
        favoriteImage = true
        let image = DogImage(image: self.image)
        imageList.addFavoriteImage(image)
    }
    
    // MARK:- Constants
    private let height: CGFloat = 300
    private let backgroundOpacity: Double = 0.5
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(imageList: FavoriteImageList())
    }
}
