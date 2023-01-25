//
//  Banner.swift
//  DomainStore
//
//  Created by Rio Rizky Rainey Ferbiansyah on 23/12/22.
//

import Foundation

public struct Banner: Codable {
    public let id: Int?
    public let name: String?
    public let imgPath: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imgPath = "img_path"
    }

    public init(id: Int?, name: String?, imgPath: String?) {
        self.id = id
        self.name = name
        self.imgPath = imgPath
    }
}

