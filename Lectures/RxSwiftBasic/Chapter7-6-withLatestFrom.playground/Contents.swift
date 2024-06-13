import UIKit
import RxSwift

/*:
 ## withLatestFrom - Combining Operator
 * 트리거 옵저버블이 Next를 방출하면 데이터 옵저버블이 최근에 방출한 Next를 전달
 */

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()

trigger.withLatestFrom(data)
    .subscribe { print($0) }
    .disposed(by: bag)

data.onNext("Hello") // 아직 trigger되지 않음
trigger.onNext(()) // next(Hello)
trigger.onNext(()) // next(Hello)

//data.onCompleted() // completed 전달되지 않음
//data.onError(MyError.error)
//trigger.onNext(()) // 바로 에러전달

trigger.onCompleted() // 바로 completed 전달
