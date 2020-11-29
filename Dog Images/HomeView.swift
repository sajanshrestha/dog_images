//
//  ContentView.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State private var favorite = false
    @State private var selectedBreed = 0
    @State private var breeds = ["random"]
    
    @State private var showCreateMemeView = false
    
    @ObservedObject var imageModel: DogImageModel
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                PickerView(breeds: breeds, selectedBreed: $selectedBreed)
                
                Spacer()
                
                if imageModel.displayedImage != nil {
                    ImageView(image: imageModel.displayedImage ?? UIImage(), favorite: $favorite) {
                        
                        if !self.favorite {
                            self.setImageAsFavorite()
                        }
                    }
                }
                
                else {
                    
                    Image(systemName: "hourglass").imageScale(.large).spinning()
                }
                
                Spacer()
                
            }
            .navigationBarItems(
                
                leading: Button("Create Meme") { self.showCreateMemeView = true },
                trailing: Button(action: { self.nextImage() }, label: { Text("Next")})
            )
                .onAppear {
                    self.setBreeds()
                    self.nextImage()
                    
            }
                .sheet(isPresented: $showCreateMemeView) { CreateMemeView(image: self.imageModel.displayedImage ?? UIImage(), imageList: self.imageModel) }
        }
    }
    
    private func setImageAsFavorite() {
        
        favorite = true
        guard let imageData = self.imageModel.displayedImage!.pngData() else { return }
        var image = DogImage(imageData: imageData)
        image.setFavorite(to: true)
        imageModel.addDogImage(image)
    }
    
    private func nextImage() {
        
        imageModel.setRandomImage(for: breeds[selectedBreed])
        self.favorite = false
    }
    
    private func setBreeds() {
        
        Service.getBreedList { breeds in
            self.breeds.append(contentsOf: breeds)
            
        }
    }
    
    private let height: CGFloat = 340
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(imageModel: DogImageModel())
    }
}


struct PickerView: View {
    
    var breeds: [String]
    @Binding var selectedBreed: Int
    
    var body: some View {
        
        Form {
            Picker("Breed", selection: $selectedBreed) {
                ForEach(0..<breeds.count, id: \.self) { index in
                    Text(self.breeds[index])
                }
            }
        }
        .frame(height: height)
    }
    
    private let height: CGFloat = 50
}


struct ImageView: View {
    
    var image: UIImage
    @Binding var favorite: Bool
    var onHeartButtonClicked: () -> ()
    
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            
            HStack {
                HeartImage(addedToList: $favorite) {
                    self.onHeartButtonClicked()
                }
                .padding()
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color.white.opacity(backgroundOpacity))
            
        }
    }
    
    private let backgroundOpacity: Double = 0.5
    
}
