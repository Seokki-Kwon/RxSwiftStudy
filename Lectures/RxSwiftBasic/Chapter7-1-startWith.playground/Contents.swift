import UIKit
import RxSwift

/*:
 ## startWith - Combining Operator
 * 옵저버블 시퀀스 앞에 새로운 요소를 추가하는 결합연산자
 */

let bag = DisposeBag()
let numbers = [1, 2, 3, 4, 5]

Observable.from(numbers)
    .startWith(0) // 0을 붙힌다.
    .startWith(-1, -2)
    .startWith(-3)
    .subscribe { print($0) }
    .disposed(by: bag)

// -3, -1, -2, 0 순서대로 방출(Last In First Out)

