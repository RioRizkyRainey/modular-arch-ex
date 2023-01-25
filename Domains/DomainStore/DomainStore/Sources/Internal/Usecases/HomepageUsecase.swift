//
//  HomepageUsecase.swift
//  DomainStore
//
//  Created by Rio Rizky Rainey Ferbiansyah on 23/12/22.
//

import Foundation
import HttpHandler

class HomepageUsecase: HttpUsecase {
    typealias Response = Response<Homepage>
    
    var url: String {
        baseUrl + "dbl-store/home"
    }
}
