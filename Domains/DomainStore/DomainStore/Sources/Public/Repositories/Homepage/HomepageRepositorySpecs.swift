//
//  HomepageRepository.swift
//  DomainStore
//
//  Created by Rio Rizky Rainey Ferbiansyah on 23/12/22.
//

import Foundation

public protocol HomepageRepositorySpecs {
    func homepage(completion: @escaping (Result<Homepage, Error>) -> Void )
}
