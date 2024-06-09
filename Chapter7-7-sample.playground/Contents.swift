import UIKit
import RxSwift

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()

data.sample(trigger)
    .subscribe { print($0) }
    .disposed(by: bag)

trigger.onNext(())
data.onNext("Hellod")

trigger.onNext(()) //  가장 최근의 이벤트 방출
trigger.onNext(()) // 동일한 데이터는 방출하지 않는다

data.onCompleted()
trigger.onNext(()) // completed 전달

data.onError(MyError.error)
