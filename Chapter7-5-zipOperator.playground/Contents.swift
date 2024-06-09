import UIKit
import RxSwift

/*:
 ## zip - Combining Operator
 * indexed Sequencing을 구현하는 연산자
 */

// 첫번째 요소는 첫번째 요소와 결합한다
// comineLatest와 다르게 무조건 짝을 맞춰서 방출
// 결합할 짝이 없는경우 방출하지 않는다.

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let numbers = PublishSubject<Int>()
let strings = PublishSubject<String>()

Observable.zip(numbers, strings) { "\($0) - \($1)"}
    .subscribe { print($0) }
    .disposed(by: bag)

numbers.onNext(1)
strings.onNext("one") // 1 - one
    
numbers.onNext(2)
strings.onNext("two") // 2 - two

numbers.onCompleted() // 하나라도 completed가 전달되면 더이상 방출하지 않는다.
strings.onCompleted() // 2개의 소스모두 completed가 전달되면 최종적으로 종료


