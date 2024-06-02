import UIKit
import RxSwift

enum MyError: Error {
    case error
}

let disposeBag = DisposeBag()

// Behavior Subject
// 가장 최근 이벤트를 저장하고 새로운 구독자에게 전달
// OnError, OnCompleted인경우 next이벤트를 전달받지 않는다.

// PublishSubject 차이 비교
let p = PublishSubject<Int>()
p.subscribe { print("PublishSubject >>", $0) } // 내부에 이벤트가 저장되지 않는상태로 생성
    .disposed(by: disposeBag)


let b = BehaviorSubject<Int>(value: 0)
b.subscribe { print("Behavior Subject >>", $0) } // 바로 next 이벤트가 전달됨(내부에 next이벤트가 생성되있음)
    .disposed(by: disposeBag)

b.onNext(1)

b.subscribe { print("Behavior Subject2 >>", $0) } // 바로 next 이벤트가 전달됨(내부에 next이벤트가 생성되있음)
    .disposed(by: disposeBag)

b.onCompleted()
//b.onError(MyError.error)

// completed, error 상태만 전달받음
b.subscribe { print("Behavior Subject3 >>", $0) } // 바로 next 이벤트가 전달됨(내부에 next이벤트가 생성되있음)
    .disposed(by: disposeBag)


