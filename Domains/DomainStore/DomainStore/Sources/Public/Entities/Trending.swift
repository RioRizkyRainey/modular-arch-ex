//
//  Trending.swift
//  DomainStore
//
//  Created by Rio Rizky Rainey Ferbiansyah on 23/12/22.
//

import Foundation

public struct Trending: Codable {
    public let title: String?
    public let items: [Product]?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case items = "items"
    }

    public init(title: String?, items: [Product]?) {
        self.title = title
        self.items = items
    }
}
