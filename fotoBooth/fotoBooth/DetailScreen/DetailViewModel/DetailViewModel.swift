//
//  DetailViewModel.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 01.09.2023.
//

import Foundation
import UIKit

class DetailViewModel: ObservableObject {
    
    @Published var item: PhotoElement
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var title: String? = nil
    
    init(photo: PhotoElement) {
        self.item = photo
        self.title = photo.title
        loadImage()
    }
    
    
    private func loadImage(cache: ImageCache = .shared) {
        if let cachedImageData = cache.getImage(forKey: NSString(string: item.url ?? "")) {
            if let cachedImage = UIImage(data: cachedImageData) {
                self.image = cachedImage
                self.isLoading = false
                return
            }
        }
    }
}

