import UIKit
import RxSwift

/*:
 ## combineLatest - Combining Operator
 */

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let greetings = PublishSubject<String>()
let languages = PublishSubject<String>()

// 클로저 파라미터를 통해서 next이벤트를 전달
Observable.combineLatest(greetings, languages) { lhs, rhs -> String in
    return "\(lhs) \(rhs)"
}
.subscribe { print($0) }
.disposed(by: bag)


greetings.onNext("Hi")
languages.onNext("World!") // 이시점 이후부터 이벤트 전달! next(Hi World!)

greetings.onNext("Hello") // Hello World!
languages.onNext("RxSwift") // Hello RxSwift

//greetings.onCompleted()
greetings.onError(MyError.error) // 소스중 하나라도 에러를 방출시 즉시종료
languages.onNext("SwiftUI") // Hello SwiftUI greetings는 최신값을 사용

languages.onCompleted() // Completed 전달




