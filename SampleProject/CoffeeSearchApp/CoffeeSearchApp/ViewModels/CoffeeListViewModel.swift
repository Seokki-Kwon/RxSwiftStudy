//
//  CoffeeListViewModel.swift
//  CoffeeSearchApp
//
//  Created by 석기권 on 6/14/24.
//

import Foundation
import RxSwift



class CoffeeListViewModel {
    let bag = DisposeBag()
    let coffeeSubject = BehaviorSubject<[Coffee]>(value: [])
    let wishlistSubject = BehaviorSubject<[Coffee]>(value: [])
    
    init() {
        APIService.fetchAllCoffee()
            .map { $0 }
            .subscribe(onNext: { [weak self] in     
                print("성공^^")
                self?.coffeeSubject.onNext($0)
            })
            .disposed(by: bag)
    }
    
    func addWishlist(_ item: Coffee) {        
        wishlistSubject.onNext([item])
    }
}
