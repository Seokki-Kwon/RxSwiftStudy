import UIKit
import RxSwift

let disposeBag = DisposeBag()

// range
Observable.range(start: 1, count: 10)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// generate
// initialState: 초기값
// condition: true를 리턴하는 경우에만 방출, false -> complete후 종료
// iterate: 값을 바꾸는 코드
// 10을 초과하면 completed 전달하고 종료
Observable.generate(initialState: 0, condition: {$0 <= 10}, iterate: {$0 + 2})
    .subscribe { print($0) }
    .disposed(by: disposeBag)

let red = "🔴"
let blue = "🔵"
Observable.generate(initialState: red, condition: {$0.count < 15}, iterate: {$0.count.isMultiple(of: 2) ? $0 + red : $0 + blue})
    .subscribe { print($0) }
    .disposed(by: disposeBag)
