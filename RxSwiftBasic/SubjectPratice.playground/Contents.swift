import UIKit
import RxSwift

let subject = BehaviorSubject(value: 1)

subject.onNext(2) // 값을 전달할수도(Observer)

// 값을 구독도 가능(Observable)
subject
    .subscribe { num in
        print(num)
    }


subject.onNext(3)
subject.onNext(4)
