import UIKit
import RxSwift


let bag = DisposeBag()
enum MyError: Error {
    case error
}

let o = Observable.range(start: 1, count: 5)

// scan 새로운 이벤트가 방출되면 구독자가 이벤트를 전달받음(중간결과가 필요한 경우)
print("== scan")

o.scan(0, accumulator: +)
    .subscribe { print($0) }
    .disposed(by: bag)

// reduce 최종결과를 구독자에게 전달
print("== reduce")
o.reduce(0, accumulator: +)
    .subscribe { print($0) }
    .disposed(by: bag)


