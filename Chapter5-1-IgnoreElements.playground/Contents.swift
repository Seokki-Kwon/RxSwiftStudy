import UIKit
import RxSwift

// IgnoreElements - Filter Operators

let disposeBag = DisposeBag()
let fruits = ["🍏", "🍎", "🍋", "🍓", "🍇"]

// next를 무시
// 작업에 성공과 실패에 관심있을떄만 사용
// RxSwift6부터 Observable<Never> 리턴(RxSwif5 Completable 리턴)
Observable.from(fruits)
.ignoreElements() // ignoreElements로 next이벤트 필터링
.subscribe { print($0) }
.disposed(by: disposeBag)
