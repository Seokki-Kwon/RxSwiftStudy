import UIKit
import RxSwift

enum MyError: Error {
    case unknown
}

// Observable 구현
let observable = Observable<String>.create { observer in
    observer.onNext("Hello")
    observer.onNext("Observable")
    
    observer.onCompleted()
    
    return Disposables.create()
}

// Infallible
// 에러를 전달하지 않는다.
// next, completed만 방출
let infallible = Infallible<String>.create { observer in
//    observer.onNext("Hello") // Infallible에서는 불가능
    observer(.next("Hello"))
    observer(.completed)
    
    return Disposables.create()
}
