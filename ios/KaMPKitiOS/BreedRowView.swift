//
//  BreedRowView.swift
//  KaMPKitiOS
//
//  Created by Brady Aiello on 7/10/21.
//  Copyright © 2021 Touchlab. All rights reserved.
//

import SwiftUI
import shared

struct BreedRowView: View {
    var breed: Breed
    var onTap: (Breed) -> Void
    
    init(_ breed: Breed,_ onTap: @escaping(Breed) -> ()) {
        self.breed = breed
        self.onTap = onTap
    }
    
    var body: some View {
        HStack() {
            Text(breed.name)
                .padding(4.0)
            Spacer()
            Image(systemName: (breed.favorite == 0) ? "heart" : "heart.fill")
                .padding(4.0)
        }.onTapGesture {
            onTap(breed)
        }
    }
}
