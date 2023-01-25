//
//  StoreHomepageHeaderViewModel.swift
//  Store
//
//  Created by Rio Rizky Rainey Ferbiansyah on 22/12/22.
//

import Foundation
import RxSwift
import RxRelay

protocol StoreHomepageHeaderViewModel {
    var text: Observable<String> { get }
    
    var images: Observable<[String]> { get }
}

final class StoreHomepageHeaderViewModelDefault: StoreHomepageHeaderViewModel {
    var text: Observable<String> {
        _text.asObservable()
    }
    
    var images: Observable<[String]> {
        _images.asObservable()
    }
    
    var _text = BehaviorRelay<String>(value: "")
    
    var _images = BehaviorRelay<[String]>(value: [])
    
    init(images: [String]) {
        self._images.accept(images)
    }
}
