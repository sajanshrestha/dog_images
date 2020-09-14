//
//  HeartImage.swift
//  Dog Images
//
//  Created by Sajan Shrestha on 7/10/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct HeartImage: View {
    
    @Binding var addedToList: Bool
    var action: () -> Void
    
    var body: some View {
        Image(systemName: addedToList ? "heart.fill": "heart")
            .font(.title)
            .foregroundColor(.red)
            .onTapGesture {
                self.action()
        }
    }
}
