import UIKit
import RxSwift

let bag = DisposeBag()

let backgroundScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
/*:
 ## Scheduler
 * observe(on:) 이어지는 메서드를 지정한 스케줄러로 지정
 */
// 아무런 스케줄러를 지정하지 않는다면 MainThread에서 실행됨
Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .subscribeOn(MainScheduler.instance)
    .filter { num -> Bool in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> filter")
        return num.isMultiple(of: 2)
    }
    .observe(on: backgroundScheduler) // background 스케줄러로 지정
    .map { num -> Int in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> map")
        return num * 2
    }
    .observe(on: MainScheduler.instance)
    .subscribe {
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> subscribe")
        print($0)
    } // Observable이 생성되는 시점은 구독하는 시점
    .disposed(by: bag)

// ⭐️⭐️ subscribeOn 메서드는 subscribe가 작업하는 스케줄러를 지정하는게 아니다
// subscribeOn는 옵저버블이 시작되는 시점에 어떠한 스케줄러를 사용할지 지정한다.
// subscribeOn는 호출시점이 중요하지 않음

