//
//  HompageRepository.swift
//  DomainStore
//
//  Created by Rio Rizky Rainey Ferbiansyah on 23/12/22.
//

import Foundation
import HttpHandler

public final class HomepageRepository: HomepageRepositorySpecs {
    
    private let httpHandler: HttpHandlerSpecs
    
    public init(httpHandler: HttpHandlerSpecs = HttpHandler()) {
        self.httpHandler = httpHandler
    }
    
    func homepage(completion: @escaping (Result<Homepage, Error>) -> Void) {
        httpHandler.request(HomepageUsecase()) { (result: Result<Response<Homepage>, Error>) in
            switch result {
            case .success(let response):
                if let homepage = response.data {
                    completion(.success(homepage))
                } else if let error = response.message {
                    completion(
                        .failure(
                            NSError(domain: "DomainStore", code: 0, userInfo: [NSLocalizedDescriptionKey: error])
                        )
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
