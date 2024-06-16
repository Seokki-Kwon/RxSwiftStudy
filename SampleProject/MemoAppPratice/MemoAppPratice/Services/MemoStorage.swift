//
//  MemoStorage.swift
//  MemoAppPratice
//
//  Created by 석기권 on 6/17/24.
//

import Foundation
import RxSwift
import RxCocoa

class MemoStorage: MemoStorageType {
    private var memoList: [Memo] = [
        Memo(id: 0, title: "테스트메모1", content: "내용"),
        Memo(id: 1, title: "테스트메모2", content: "내용"),
    ]
    
    private lazy var store = BehaviorRelay(value: memoList)
    
    func getAllMemo() -> Observable<[Memo]> {
        return store.asObservable()
    }
    
    func updateMemo(memo: Memo) -> Observable<Memo> {
        let findMemo = store.value.filter { $0.id == memo.id }
        var updateMemo = store.value
        
        if !findMemo.isEmpty {
            let index = store.value.firstIndex(where: { $0.id == findMemo[0].id })!
            updateMemo[index] = memo
        } else {
            updateMemo.insert(memo, at: 0)
        }
        
        store.accept(updateMemo)
        return Observable.just(memo)
    }
    
    func deleteMemo(memo: Memo) -> Observable<Void> {
        return Observable.empty()
    }
}
