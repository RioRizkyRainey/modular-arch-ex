//
//  HttpMethod.swift
//  Accenture-Rio
//
//  Created by Rio Rizky Rainey Ferbiansyah on 14/12/22.
//

import Foundation

public enum HttpMethod: String {
    
    /// Requests a representation of the specified resource. Requests using `get` should only retrieve data.
    case get = "GET"
    
    /// Asks for a response identical to that of a `get` request, but without the response body.
    case head = "HEAD"
    
    /// Used to submit an entity to the specified resource, often causing a change in state or side effects on the server.
    case post = "POST"
    
    /// Replaces all current representations of the target resource with the request payload.
    case put = "PUT"
    
    /// Deletes the specified resource.
    case delete = "DELETE"
    
    /// Establishes a tunnel to the server identified by the target resource.
    case connect = "CONNECT"
    
    /// Used to describe the communication options for the target resource.
    case options = "OPTIONS"
    
    /// Performs a message loop-back test along the path to the target resource.
    case trace = "TRACE"
    
    /// Used to apply partial modifications to a resource.
    case patch = "PATCH"
}
