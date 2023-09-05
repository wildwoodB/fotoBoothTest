//
//  APIErrors.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 01.09.2023.
//

import Foundation

enum PhotoDataMangerErrors: Error {
    case faileedToGEtData
    case faleedAPI
    case emptyData
    case decodingFail
    case badResponse(URLResponse?)
}
