//
//  HttpHandler.swift
//  HttpHandler
//
//  Created by Rio Rizky Rainey Ferbiansyah on 23/12/22.
//

import Foundation

public class HttpHandler: HttpHandlerSpecs {
    private let session: URLSessionProtocol
        
    public init(session: URLSessionProtocol = URLSession.init(configuration: .default)) {
        self.session = session
    }
    
    public func request<U: HttpUsecase>(_ usecase: U, completion: @escaping (Result<U.Response, Error>) -> Void) {
        HttpHandlerStandard(session: session).request(usecase, completion: completion)
    }
}
