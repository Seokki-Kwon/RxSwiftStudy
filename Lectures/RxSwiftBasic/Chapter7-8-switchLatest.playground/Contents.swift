import UIKit
import RxSwift

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let a = PublishSubject<String>()
let b = PublishSubject<String>()

let source = PublishSubject<Observable<String>>() // 문자열을 방출하는 옵저버블을 방출하는 서브젝트

source
    .switchLatest()
    .subscribe { print($0) }
    .disposed(by: bag)

a.onNext("1")
b.onNext("b")

source.onNext(a) // a가 최신 옵저버블이됨

a.onNext("2")
b.onNext("b")

source.onNext(b) // b가 최신 옵저버블이됨

a.onNext("3")
b.onNext("c")

a.onCompleted()
b.onCompleted()

source.onCompleted() // source로 completed를 전달해야 구독자로 전달됨


