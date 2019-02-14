//
//  URL+Extension.swift
//  NASA Picture of the Day
//
//  Created by Denis Bystruev on 14/02/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        
        components?.queryItems = queries.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return components?.url
    }
}
