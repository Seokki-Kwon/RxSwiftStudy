//
//  MemoDetailViewModel.swift
//  MemoAppPratice
//
//  Created by 석기권 on 6/18/24.
//

import Foundation
import RxSwift
import RxCocoa

class MemoDetailViewModel: ViewModelType {
    let memo: Memo
    lazy var memoSubject = BehaviorSubject<Memo>(value: memo)
    
    var memoTitleObservable: Observable<String> {
        return memoSubject.map { $0.title }.asObservable()
    }
    
    var memoContentObservable: Observable<String> {
        return memoSubject.map { $0.content }.asObservable()
    }
    
    init(memo: Memo, storage: MemoStorageType) {
        self.memo = memo
        super.init(storage: storage)
    }
}
