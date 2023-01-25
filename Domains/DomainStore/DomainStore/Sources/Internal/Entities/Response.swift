//
//  BaseResponse.swift
//  DomainStore
//
//  Created by Rio Rizky Rainey Ferbiansyah on 23/12/22.
//

import Foundation

class Response<T: Decodable>: Decodable {
    let message: String?
    let data: T?
}
