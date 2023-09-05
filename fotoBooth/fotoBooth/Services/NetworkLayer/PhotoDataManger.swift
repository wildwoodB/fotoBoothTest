//
//  PhotoDataService.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 01.09.2023.
//

import Foundation


class PhotoDataManger {
    
    static let shared = PhotoDataManger()
    private let queue = DispatchQueue(label: "com.example.DownloadImage", attributes: .concurrent)
    
    private let baseUrl = "https://jsonplaceholder.typicode.com"
    
    private enum Endpoint: String {
        case photos = "/photos"
    }
    
    private func createRequest(with url: URL?,type: HTTPMethod,completion: @escaping(URLRequest) -> Void) {
        guard let urlString = url else { return }
        var request = URLRequest(url: urlString)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
    
    func fetchPhotos(completion: @escaping (Result<[PhotoElement],Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + Endpoint.photos.rawValue) else {
            completion(.failure(PhotoDataMangerErrors.faleedAPI))
            return
        }
        
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Download data fail!: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(PhotoDataMangerErrors.badResponse(response)))
                    return
                }
                
                guard let data = data else {
                    print("Empty data!")
                    completion(.failure(PhotoDataMangerErrors.emptyData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let photos = try decoder.decode([PhotoElement].self, from: data)
                    self.queue.async(flags: .barrier) {
                        completion(.success(photos))
                    }
                } catch {
                    print("Decoding data fail!: \(error.localizedDescription)")
                    completion(.failure(PhotoDataMangerErrors.decodingFail))
                }
            }
            task.resume()
        }
        
    }
}
