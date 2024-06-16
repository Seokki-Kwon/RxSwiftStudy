//
//  CoffeeListViewModel.swift
//  CoffeeSearchApp
//
//  Created by 석기권 on 6/14/24.
//

import Foundation
import RxSwift
import RxCocoa

class CoffeeListViewModel {
    let bag = DisposeBag()
    let coffeeSubject = BehaviorSubject<[Coffee]>(value: [])
    let wishlistRelay = BehaviorRelay<[Coffee]>(value: [])
    
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
        wishlistRelay.accept(wishlistRelay.value + [item])
    }
    
    func removeProduct() {
        wishlistRelay.accept([])
    }
}
