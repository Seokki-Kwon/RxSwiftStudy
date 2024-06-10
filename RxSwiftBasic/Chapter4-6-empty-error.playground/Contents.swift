import UIKit
import RxSwift

let disposeBag = DisposeBag()

// empty
// 아무런 동작없이 옵저버블이 종료되야 하는경우
Observable<Void>.empty()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// error

enum MyError: Error {
    case error
}

Observable<Void>.error(MyError.error)
    .subscribe { print($0) }
    .disposed(by: disposeBag)


