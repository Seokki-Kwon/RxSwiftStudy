import UIKit
import RxSwift

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// single - 첫번째 요소를 방출
Observable.just(1)
    .single()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// 2개이상의 에러를 방출하거나 이벤트를 방출하지 않는다면 에러발생
Observable.from(numbers)
    .single { $0 == 3 } // filter처럼 사용가능
    .subscribe { print($0) } // error(Sequence contains more than one element.) 방출
    .disposed(by: disposeBag)

let subject = PublishSubject<Int>()

subject.single()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(100)
// 하나의 요소가 방출되는것을 보장할떄 사용
