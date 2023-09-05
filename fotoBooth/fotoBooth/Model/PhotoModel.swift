//
//  PhotoModel.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 01.09.2023.
//

import Foundation
import UIKit

struct PhotoElement: Identifiable, Codable {
    let albumID: Int?
    let id: Int
    let title: String?
    let url: String?
    let thumbnailURL: String?
}
