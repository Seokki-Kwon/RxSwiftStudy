import UIKit
import RxSwift

/*:
  ## flatMapLatest - Filtering Operator
 * 최근의 이너 옵저버블만 방출
 */

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redHeart = "❤️"
let greenHeart = "💚"
let blueHeart = "💙"

let sourceObservable = PublishSubject<String>()
let trigger = PublishSubject<Void>()

sourceObservable
    .flatMapLatest { circle -> Observable<String> in
        switch circle {
            // trigger가 요소를 방출할때까지 같은 색상의 하트를 방출한다
        case redCircle:
            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .map { _ in redHeart }
                .take(until: trigger)
        case greenCircle:
            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .map { _ in greenHeart }
                .take(until: trigger)
        case blueCircle:
            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .map { _ in blueHeart }
                .take(until: trigger)
        default:
            return Observable.just("")
        }
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

sourceObservable.onNext(redCircle)

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    sourceObservable.onNext(greenHeart)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    sourceObservable.onNext(blueCircle)
}

// 10초뒤에 trigger로 next이벤트를 보내서 모든 옵저버블을 종료
DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
    trigger.onNext(())
}
