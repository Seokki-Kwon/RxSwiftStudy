import UIKit
import RxSwift

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// AsyncSubject
// Completed가 될떄까지 전달하지 않는다.
// Completed가 되면 최근에 이벤트를 전달한다.

let subject = AsyncSubject<Int>()

subject.subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(1)

subject.onNext(2)
subject.onNext(3)

// 해당 시점을 기준으로 가장 최근에전달된 next이벤트 전달
// 이벤트가 없다면 Completd만 전달되고 종료
subject.onCompleted()

// 에러이벤트가 전달된 경우 error만 전달되고 종료 next는 전달되지 않는다.
subject.onError(MyError.error)
