//
//  DataBase.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 04.09.2023.
//

import Foundation

final class DataBase {
    
    @Published var photos: [PhotoElement] = []
    
    private let FAV_KEY = "FavoritePhotos"
    private let userDefaults = UserDefaults.standard
    private var photoDataManager = PhotoDataManger.shared
    
    init(photoDataManager: PhotoDataManger = PhotoDataManger.shared) {
        self.photoDataManager = photoDataManager
        
    }
    
    func save(item: Set<Int>) {
        let array = Array(item)
        userDefaults.set(array, forKey: FAV_KEY)
    }
    
    func load() -> Set<Int> {
        let array = userDefaults.array(forKey: FAV_KEY) as? [Int] ?? [Int]()
        return Set(array)
    }
}
