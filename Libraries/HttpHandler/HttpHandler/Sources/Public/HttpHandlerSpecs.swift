//
//  HttpHandlerSpecs.swift
//  HttpHandler
//
//  Created by Rio Rizky Rainey Ferbiansyah on 23/12/22.
//

import Foundation

public protocol HttpHandlerSpecs {
    func request<U: HttpUsecase>(_ usecase: U, completion: @escaping (Result<U.Response, Error>) -> Void)
}
