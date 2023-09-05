//
//  ImageLoadingService.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 03.09.2023.
//
import UIKit

class ImageLoadingService {
    
    private let cache: ImageCache
    
    init(cache: ImageCache = .shared, item: PhotoElement) {
        self.cache = cache
    }
    
    func updateImage(for photo: PhotoElement, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: photo.url ?? "") else {
            print("Cannot create URL!")
            completion(nil)
            return
        }
        
        if let cachedImageData = cache.getImage(forKey: NSString(string: photo.url ?? "")) {
            if let cachedImage = UIImage(data: cachedImageData) {
                completion(cachedImage)
                return
            }
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: imageUrl) { [weak self] (data, _, error) in
            if let error = error {
                print("Failed to download image data: \(error)")
                completion(nil)
                return
            }
            
            if let imageData = data, let image = UIImage(data: imageData) {
                if let compressedData = image.jpegData(compressionQuality: 0.8) {
                    self?.cache.setImage(object: compressedData as NSData, forKey: photo.url ?? "")
                    completion(image)
                } else {
                    print("Failed to compress image data")
                    completion(nil)
                }
            } else {
                print("Cannot create image from data!")
                completion(nil)
            }
        }
        task.resume()
    }
}



