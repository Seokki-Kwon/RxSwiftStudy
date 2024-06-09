import UIKit
import RxSwift

/*:
 ## amb - Conditional Operator
 * 여러 옵저버블 중에서 가장 먼저 이벤트를 방출하는 옵저버블을 선택
 */

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let a = PublishSubject<String>()
let b = PublishSubject<String>()
let c = PublishSubject<String>()

// 두개의 옵저버블 중에서 먼저 이벤트를 방출하는 옵저버블을 구독
// 인스턴스 메서드
a.amb(b)
    .subscribe { print($0) }
    .disposed(by: bag)

a.onNext("A") // 이벤트 구독
b.onNext("B") // 이벤트 무시

b.onCompleted() // 전달되지 않는다.
a.onCompleted() // Completed 전달

// 타입메서드
Observable.amb([a, b, c])
    .subscribe { print($0) }
    .disposed(by: bag)




