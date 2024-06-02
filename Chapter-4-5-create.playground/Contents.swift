import UIKit
import RxSwift

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// onNext: 요소를 방출
// onCompleted, onError: 옵저버블 종료
Observable<String>.create { (observer) -> Disposable in
    guard let url = URL(string: "https://www.apple.com") else {
        observer.onError(MyError.error)
        return Disposables.create()
    }
    guard let html = try? String(contentsOf: url, encoding: .utf8) else {
        observer.onError(MyError.error)
        return Disposables.create()
    }
    
    observer.onNext(html)
    observer.onCompleted()
    return Disposables.create()
}
.subscribe { print($0) }
.disposed(by: disposeBag)

