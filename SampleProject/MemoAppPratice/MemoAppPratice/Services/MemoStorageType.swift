//
//  MemoStorageType.swift
//  MemoAppPratice
//
//  Created by 석기권 on 6/17/24.
//

import Foundation
import RxSwift

protocol MemoStorageType {
    func updateMemo(memo: Memo) -> Observable<Memo>
    func deleteMemo(memo: Memo) -> Observable<Void>
    func getAllMemo() -> Observable<[Memo]>
}
