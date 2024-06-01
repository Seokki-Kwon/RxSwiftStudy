import UIKit
import RxSwift
import RxCocoa

let bag = DisposeBag()

let prelay = PublishRelay<Int>()

// Relay
// 다른 소스로부터 이벤트를 받아서 구독자에게 전달
// Completed, Error는 다루지않는다(dispose 되기전까지 계속사용)
// UI에 주로사용
// RxSwift가 아닌 RxCocoa에서 제공함

prelay.subscribe { print("1: \($0)") }
    .disposed(by: bag)


// next대신 accept -> 새로운 이벤트를 전달
prelay.accept(1)

let brelay = BehaviorRelay(value: 1)
brelay.accept(2)

brelay.subscribe {
    print("2: \($0)")
}
.disposed(by: bag)

brelay.accept(3)

print(brelay.value) // 읽기전용
