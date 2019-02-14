//
//  PhotoInfo.swift
//  NASA Picture of the Day
//
//  Created by Denis Bystruev on 14/02/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try valueContainer.decode(String.self, forKey: .title)
        description = try valueContainer.decode(String.self, forKey: .description)
        url = try valueContainer.decode(URL.self, forKey: .url)
        copyright = try? valueContainer.decode(String.self, forKey: .copyright)
    }
}
