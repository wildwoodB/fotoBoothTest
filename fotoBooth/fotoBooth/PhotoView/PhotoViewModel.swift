//
//  PhotoCellViewModel.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 01.09.2023.
//

import SwiftUI

class PhotoViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let queue = DispatchQueue.global(qos: .userInitiated)
    private let imageLoadingService: ImageLoadingService
    private let photo: PhotoElement
    
    
    init(photo: PhotoElement) {
        self.imageLoadingService = ImageLoadingService(item: photo)
        self.photo = photo
        self.imageUpdate()
        self.isLoading = true
        
    }
    
    private func imageUpdate() {
        
        let currentPhotoId = self.photo.id
        
        imageLoadingService.updateImage(for: self.photo) { [weak self] image in
            if let image = image {
                DispatchQueue.main.async {
                    self?.image = image
                    self?.isLoading = false
                }
            } else {
                print("Failed to load image")
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
            }
        }
    }
}
