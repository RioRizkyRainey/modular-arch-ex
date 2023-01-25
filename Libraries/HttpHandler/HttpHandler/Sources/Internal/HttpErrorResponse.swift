//
//  HttpErrorResponse.swift
//  Accenture-Rio
//
//  Created by Rio Rizky Rainey Ferbiansyah on 14/12/22.
//

import Foundation

enum HttpErrorResponse: Error {
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
