//
//  PhotoCellView.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 01.09.2023.
//

import SwiftUI

struct PhotoView: View {
    
    @ObservedObject var vm: PhotoViewModel
    
    init(photo: PhotoElement) {
        self.vm = PhotoViewModel(photo: photo)
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.gray)
            }
        }
        .frame(width: 150, height: 150)
    }
}


