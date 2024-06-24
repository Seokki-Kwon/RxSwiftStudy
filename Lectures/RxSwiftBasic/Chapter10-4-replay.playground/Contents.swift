import UIKit
import RxSwift

let bag = DisposeBag()
//let subject = ReplaySubject<Int>.create(bufferSize: 5)

// replayAll 사용은 지양 -> 버퍼크기의 제한이 없음
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(5)
    .replay(5) // buffer크기 신중하게 지정해야함

source
    .subscribe { print("🔵", $0)}
    .disposed(by: bag)

source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance) // 구독시점을 3초 지연
    .subscribe { print("🔴", $0)}
    .disposed(by: bag)

source.connect()

