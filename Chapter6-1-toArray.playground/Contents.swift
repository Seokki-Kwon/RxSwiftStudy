import UIKit
import RxSwift

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5 , 6, 7, 8, 9, 10]

/* 
 toArray - Transforming Operator
 옵저버블이 방출하는 모든 이벤트를 완료시점에 배열로 방출
*/

let subject = PublishSubject<Int>()

subject
    .toArray()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(1) // 방출되지 않는다.
subject.onNext(2) // 방출되지 않는다.
subject.onCompleted() // success([1, 2]) 방출
