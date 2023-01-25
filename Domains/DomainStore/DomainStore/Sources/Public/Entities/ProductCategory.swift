//
//  ProductCategory.swift
//  DomainStore
//
//  Created by Rio Rizky Rainey Ferbiansyah on 23/12/22.
//

import Foundation

public struct ProductCategory: Codable {
    public let id: Int?
    public let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    public init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}
