import UIKit
import RxSwift

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// take - 처음 n개의 요소를 방출
Observable.from(numbers)
    .take(5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// takeWhile - false를 리턴할때까지
Observable.from(numbers)
    .takeWhile { !$0.isMultiple(of: 2) } // false를 리턴하면 더이상 요소를 방출하지않는다.
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// takeUntil - trigger가 요소를 방출할떄까지
let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

subject.takeUntil(trigger)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(1) // 요소를 방출
subject.onNext(2) // 요소를 방출

trigger.onNext(0) // 요소를 방출하지않고 completed방출


// takeLast
let subject1 = PublishSubject<Int>()

subject1.takeLast(2) // 마지막 2개의 요소만 버퍼에저장
    .subscribe { print($0) }
    .disposed(by: disposeBag)

numbers.forEach { subject1.onNext($0) } // 9, 10을 버퍼에 저장

subject1.onNext(11) // 10, 11을 버퍼에 저장

subject1.onCompleted() // 버퍼에 저장된 요소가 구독자로 방출

// 에러
enum MyError: Error {
    case error
}

subject1.onError(MyError.error) // 버퍼의 요소는 전달되지않고 에러만 전달됨
