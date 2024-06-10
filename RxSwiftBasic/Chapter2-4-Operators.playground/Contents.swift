import UIKit
import RxSwift

let bag = DisposeBag()

// Operators
// 연산자로 값을 필터링하여 구독자에게전달?
// 순서에유의
Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9])
    .filter { $0.isMultiple(of: 2) } // 짝수만전달
    .take(5) // 처음 5개의 요소만 전달    
    .subscribe { print($0) }
    .disposed(by: bag)
