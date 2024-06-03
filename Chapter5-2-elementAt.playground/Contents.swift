import UIKit
import RxSwift

let disposeBag = DisposeBag()
let fruits = ["🍏", "🍎", "🍋", "🍓", "🍇"]

// elementAt - Filtering Operator
// 특정 인덱스에 위치한 요소를 반환하고 completed 이벤트 전달
Observable.from(fruits)
    .element(at: 1)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
