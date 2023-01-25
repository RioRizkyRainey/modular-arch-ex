//
//  HttpUsecase.swift
//  Accenture-Rio
//
//  Created by Rio Rizky Rainey Ferbiansyah on 14/12/22.
//

import Foundation

public protocol HttpUsecase {
    
    associatedtype Response
    
    var url: String { get }
    var method: HttpMethod? { get }
    var headers: [String : String]? { get }
    var queryItems: [String : String]? { get }
    
    func map(_ data: Data) throws -> Response

}

public extension HttpUsecase where Response: Decodable {
    
    func map(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

public extension HttpUsecase {
    
    var headers: [String : String]? {
        nil
    }
    
    var queryItems: [String : String]? {
        nil
    }
    
    var method: HttpMethod? {
        .get
    }
}
