import UIKit
import RxSwift

let bag = DisposeBag()
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(5)
    .publish() // 자동으로 PublishSubject를 내부적으로 생성(직접 생성할필요 없음)

// 나머지는 multicast와 동일
source
    .subscribe { print("🔵", $0)}
    .disposed(by: bag)

source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance) // 구독시점을 3초 지연
    .subscribe { print("🔴", $0)}
    .disposed(by: bag)

source.connect()
