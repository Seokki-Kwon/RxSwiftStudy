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
    lazy var memoSubject = BehaviorRelay<[String]>(value: [memo.title, memo.content])
    var editModeSubject = PublishSubject<Bool>()
        
    
    init(memo: Memo, storage: MemoStorageType) {
        self.memo = memo
        super.init(storage: storage)        
    }
    
    func performUpdate() {
        storage.updateMemo(memo: Memo(id: memo.id, title: memoSubject.value[0], content: memoSubject.value[1]))
    }
    
    func updateContent(content: String) {
        let memo = memoSubject.value
        memoSubject.accept([memo[0], content])
    }
    
    func updateTitle(title: String) {
        let memo = memoSubject.value
        memoSubject.accept([title, memo[1]])
    }
}
