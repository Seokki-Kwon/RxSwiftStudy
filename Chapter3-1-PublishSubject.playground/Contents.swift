import UIKit
import RxSwift

// PublishSubject
// Subject로 전달되는 이벤트를 Obsever에게 전달


enum MyError: Error {
    case error
}

// Subject 생성
// 문자열이 포함된 next 이벤트를 받아서 다른 Observer에게 전달
// 최초로 생성되는 시점과 첫번째 구독이 시작되는 시점에 이벤트는 사라짐
// 이벤트가 사라지면 안되는경우 ReplaySubject 사용

let subject = PublishSubject<String>()
let disposeBag = DisposeBag()

subject.onNext("Hello")

let o1 = subject.subscribe { print(">> 1", $0)} // o1 subject가 만들어지고 새로운 이벤트가 없기때문에 출력되지 않는다.
o1.disposed(by: disposeBag)

subject.onNext("RxSwift") // 최소 여기서 이벤트가 출력됨

let o2 = subject.subscribe { print(">> 2", $0) }
o2.disposed(by: disposeBag)

subject.onNext("Subject")

//subject.onCompleted() // 모든 구독자에게 전달됨
subject.onError(MyError.error) // 모든 구독자에게 전달됨

let o3 = subject.subscribe { print(">> 3", $0) }
o3.disposed(by: disposeBag)
