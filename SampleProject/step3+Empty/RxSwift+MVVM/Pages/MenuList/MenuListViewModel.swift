//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by 석기권 on 6/13/24.
//  Copyright © 2024 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift

struct Response: Decodable {
    let menus: [MenuItem]
}

class MenuListViewModel {
    var menuObservable = BehaviorSubject<[Menu]>(value: [])
    
    lazy var itemsCount = menuObservable.map {
        $0.map { $0.count }.reduce(0, +)
    }
    
    lazy var totalPrice = menuObservable.map {
        $0.map { $0.price * $0.count }.reduce(0, +)
    }
    
    init() {
        APIService.fetchAllMenusRx()
            .map {                
                guard let response = try? JSONDecoder().decode(Response.self, from: $0) else {
                    fatalError()
                }
                return response.menus
            }
            .map {
                var menus: [Menu] = []
                $0.enumerated().forEach {
                    let menu = Menu.fromMenuItems(id: $0, item: $1)
                    menus.append(menu)
                }
                return menus
            }
            .take(1)
            .bind(to: menuObservable)
            .dispose()
    }
    
    func clearItemSelections() {
        menuObservable
            .map { menus in
                return menus.map { Menu(
                    id: $0.id,
                    name: $0.name,
                    price: $0.price,
                    count: 0) }
            }
            .take(1) // 해주지 않는다면 스트림이 계속생김
            .subscribe(onNext: {
                self.menuObservable.onNext($0)
            })
            .dispose()
    }
    
    func changeCountItem(item: Menu, increase: Int) {
        menuObservable
            .map { menus in
                menus.map { $0.id == item.id ? Menu(id: $0.id, name: $0.name, price: $0.price, count: max(0, $0.count + increase)) : $0 }
            }
            .take(1) // 해주지 않는다면 스트림이 계속생김
            .subscribe(onNext: {
                self.menuObservable.onNext($0)
            })
            .dispose()
    }
}
