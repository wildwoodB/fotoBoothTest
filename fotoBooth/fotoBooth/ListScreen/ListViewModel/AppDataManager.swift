//
//  ListViewModel.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 01.09.2023.
//

import Foundation
import SwiftUI

class AppDataManager: ObservableObject {
    
    
    @Published var photos: [PhotoElement] = []
    var photoDataManager = PhotoDataManger.shared
    @Published var showingFavs = false
    @Published var showingFiltered = false
    @Published var savedItems: Set<Int> = []
    private var db = DataBase()
    
    var filteredPhotos: [PhotoElement] {
            if showingFavs {
                return photos.filter { savedItems.contains($0.id) }
            } else if showingFiltered {
                return photos.sorted { $0.title ?? "" < $1.title ?? "" }
            } else {
                return photos
            }
        }
    
    init(downLoad: PhotoDataManger = PhotoDataManger()) {
        self.photoDataManager = downLoad
        self.savedItems = db.load()
        fetchPhotos()
    }
    
    func sortFavs() {
        withAnimation {
            showingFavs.toggle()
        }
    }
    
    func sorForTitile() {
        withAnimation {
            showingFiltered.toggle()
        }
    }
    
    func toggleFav(item: PhotoElement) {
        withAnimation {
            if contains(item) {
                savedItems.remove(item.id)
                print("убрали")
            } else {
                savedItems.insert(item.id)
                print("добавили")
            }
            db.save(item: savedItems)
        }
    }
    
    func contains(_ item: PhotoElement) -> Bool {
        savedItems.contains(item.id)
    }
    
    func fetchPhotos() {
        photoDataManager.fetchPhotos { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                DispatchQueue.main.async {
                    self?.photos = response
                }
            }
        }
    }
}
