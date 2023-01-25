//
//  HttpUsecaseExtension.swift
//  DomainStore
//
//  Created by Rio Rizky Rainey Ferbiansyah on 23/12/22.
//

import Foundation
import HttpHandler

extension HttpUsecase {
    var baseUrl: String {
        guard let baseUrl = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            return "https://www.dbl.id/api/"
        }

        return baseUrl
    }
}
