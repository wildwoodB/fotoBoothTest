//
//  ImageCache.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 01.09.2023.
//

import Foundation

class ImageCache {
    
    typealias CacheType = NSCache<NSString, NSData>
    
    static let shared = ImageCache()
    private init() {}
    
    private lazy var cache: CacheType = {
        let cache = CacheType()
        cache.countLimit = 500
        cache.totalCostLimit = 100 * 1024 * 1024
        return cache
    }()
    
    func setImage(object: NSData, forKey key: String) {
        cache.setObject(object, forKey: key as NSString)
    }
    
    func getImage(forKey key: NSString) -> Data? {
        cache.object(forKey: key ) as? Data
    }
}
