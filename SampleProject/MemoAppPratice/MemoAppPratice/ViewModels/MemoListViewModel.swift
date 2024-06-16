//
//  MemoListViewModel.swift
//  MemoAppPratice
//
//  Created by 석기권 on 6/17/24.
//

import Foundation
import RxSwift

class MemoListViewModel: ViewModelType {
    var memos: Observable<[Memo]> {
        return storage.getAllMemo()
    }
}
