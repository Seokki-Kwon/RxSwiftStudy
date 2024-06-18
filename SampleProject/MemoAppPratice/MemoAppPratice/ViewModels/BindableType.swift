//
//  BindableType.swift
//  MemoAppPratice
//
//  Created by 석기권 on 6/17/24.
//

import UIKit

// 뷰컨에서 채택하는 타입
// viewModel을 동적타입으로 받는다
protocol BindableType {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    /// ViewModel을 설정하고 bindViewModel() 메서드를 수행한다.
    mutating func bind(viewModel: ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}
