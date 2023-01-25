//
//  Homepage.swift
//  DomainStore
//
//  Created by Rio Rizky Rainey Ferbiansyah on 23/12/22.
//

import Foundation

public struct Homepage: Codable {
    public let banners: [Banner]?
    public let productCategories: [Banner]?
    public let trending: [Trending]?

    enum CodingKeys: String, CodingKey {
        case banners = "banners"
        case productCategories = "product_categories"
        case trending = "trending"
    }

    public init(banners: [Banner]?, productCategories: [Banner]?, trending: [Trending]?) {
        self.banners = banners
        self.productCategories = productCategories
        self.trending = trending
    }
}
