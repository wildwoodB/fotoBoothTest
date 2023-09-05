//
//  DetailView.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 01.09.2023.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var photo: PhotoElement?
    
    var body: some View {
        ZStack {
            if let photo = photo {
                DetailView(photo: photo)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    
    init(photo: PhotoElement) {
        _vm = StateObject(wrappedValue: DetailViewModel(photo: photo))
    }
    
    var body: some View {
        VStack {
            Image(uiImage: vm.image ?? UIImage())
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .padding(.horizontal)
            
            Text(vm.title ?? "Oops!")
                .padding()
        }
    }
}

