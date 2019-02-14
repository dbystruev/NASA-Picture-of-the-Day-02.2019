//
//  PhotoInfoController.swift
//  NASA Picture of the Day
//
//  Created by Denis Bystruev on 14/02/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class PhotoInfoController {
    
    static let shared = PhotoInfoController()
    
    private init() {}
    
    func fetchPhotoInfo(url: URL?, completion: @escaping (PhotoInfo?) -> Void) {
        guard let url = url else {
            print("Error in \(#function) on \(#line): URL is nil")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error in \(#function) on \(#line): can't read the data")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            guard let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) else {
                print("Error in \(#function) on \(#line): can't decode the data \(String(data: data, encoding: .utf8) ?? "")")
                completion(nil)
                return
            }
            
            completion(photoInfo)
            
        }.resume()
    }
    
    func fetchImage(url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            print("Error in \(#function) on \(#line): URL is nil")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error in \(#function) on \(#line): can't read the data")
                completion(nil)
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("Error in \(#function) on \(#line): can't decode the image")
                completion(nil)
                return
            }
            
            completion(image)
            
        }.resume()
    }
}
