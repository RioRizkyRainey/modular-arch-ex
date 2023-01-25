//
//  URLSessionProtocol.swift
//  Accenture-Rio
//
//  Created by Rio Rizky Rainey Ferbiansyah on 15/12/22.
//

import Foundation

public protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
