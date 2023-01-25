//
//  Product.swift
//  DomainStore
//
//  Created by Rio Rizky Rainey Ferbiansyah on 23/12/22.
//

import Foundation

public struct Product: Codable {
    public let id: Int?
    public let storeProductCategory: ProductCategory?
    public let storeSeller: Seller?
    public let name: String?
    public let imgPath: String?
    public let price: Int?
    public let priceBeforePromo: Int?
    public let stock: Int?
    public let label: Product.Label?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case storeProductCategory = "store_product_category"
        case storeSeller = "store_seller"
        case name = "name"
        case imgPath = "img_path"
        case price = "price"
        case priceBeforePromo = "price_before_promo"
        case stock = "stock"
        case label = "label"
    }

    public init(id: Int?, storeProductCategory: ProductCategory?, storeSeller: Seller?, name: String?, imgPath: String?, price: Int?, priceBeforePromo: Int?, stock: Int?, label: Product.Label?) {
        self.id = id
        self.storeProductCategory = storeProductCategory
        self.storeSeller = storeSeller
        self.name = name
        self.imgPath = imgPath
        self.price = price
        self.priceBeforePromo = priceBeforePromo
        self.stock = stock
        self.label = label
    }
    
    public struct Label: Codable {
        public let id: Int?
        public let name: String?
        public let text: String?

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case text = "text"
        }

        public init(id: Int?, name: String?, text: String?) {
            self.id = id
            self.name = name
            self.text = text
        }
    }
}
