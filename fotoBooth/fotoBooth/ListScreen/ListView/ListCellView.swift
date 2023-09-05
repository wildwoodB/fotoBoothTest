//
//  ListCellView.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 04.09.2023.
//

import SwiftUI

struct ListCellView: View {
    
    @EnvironmentObject private var vm: AppDataManager
    
    let photo: PhotoElement
    private var photoID: Int {
            photo.id
        }
    
    var body: some View {
        ZStack {
            PhotoView(photo: photo)
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                    Image(systemName: vm.contains(photo) ? "star.fill" : "star")
                        .foregroundColor(Color.red)
                        .onTapGesture {
                            vm.toggleFav(item: photo)
                        }
                }
                .animation(nil)
                .padding()
                Spacer()
            }
        }
        .frame(width: 150, height: 150)
        
    }
}

