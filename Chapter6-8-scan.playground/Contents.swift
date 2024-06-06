import UIKit
import RxSwift
/*:
  ## scan - Transforming Operator
 * Accumlator Function
 * 기본값으로 연산시작
 * 원본이 방출하는 대상으로 결과를 방출하는 하나의 옵저버블리턴
 */

let disposeBag = DisposeBag()

// 중간값이 필요한경우 사용한다.
Observable.range(start: 1, count: 10)
//    .scan(0, accumulator: +)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
