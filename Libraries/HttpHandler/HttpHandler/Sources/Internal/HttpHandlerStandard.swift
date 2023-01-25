//
//  HttpHandler.swift
//  Accenture-Rio
//
//  Created by Rio Rizky Rainey Ferbiansyah on 14/12/22.
//

import Foundation

final class HttpHandlerStandard: HttpHandlerSpecs {
    private let session: URLSessionProtocol
        
    init(session: URLSessionProtocol = URLSession.init(configuration: .default)) {
        self.session = session
    }
    
    func request<U: HttpUsecase>(_ usecase: U, completion: @escaping (Result<U.Response, Error>) -> Void) {
        
        guard let urlRequest = makeURLRequest(usecase) else {
            return completion(.failure(HttpErrorResponse.invalidEndpoint))
        }
        
        session.dataTask(with: urlRequest) { data, response, error in
            #if DEBUG
            print("[HttpHandler] - Data request:")
            print(" - URL: \(String(describing: urlRequest.url))")
            print(" - Method: \(String(describing: urlRequest.httpMethod))")
            print(" - Header: \(String(describing: urlRequest.allHTTPHeaderFields))")
            if let httpBody = urlRequest.httpBody {
                print(" - Body: \(String(decoding: httpBody, as: UTF8.self))")
            } else {
                print(" - Body: [None]")
            }
            
            if let data = data {
                let dataResponse = String(decoding: data, as: UTF8.self)
                print("[HttpHandler] - Data response: \(dataResponse)")
            } else {
                print("[HttpHandler] - Data response: data is nil")
            }
            #endif
            
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completion(.failure(HttpErrorResponse.invalidResponse))
            }
            
            guard let data = data else {
                return completion(.failure(HttpErrorResponse.noData))
            }

            do {
                let response = try usecase.map(data)
                completion(.success(response))
            } catch {
                completion(.failure(HttpErrorResponse.serializationError))
            }
        }
        .resume()
    }
    
    private func makeURLRequest<U: HttpUsecase>(_ usecase: U) -> URLRequest? {
        guard var urlComponent = URLComponents(string: usecase.url) else {
            return nil
        }
        
        var queryItems: [URLQueryItem] = []
        
        usecase.queryItems?.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = usecase.method?.rawValue ?? "GET"
        urlRequest.allHTTPHeaderFields = usecase.headers
        return urlRequest
    }
}
