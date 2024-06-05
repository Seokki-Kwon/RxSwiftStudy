import UIKit
import RxSwift

/*:
  ## flatMapFirst - Filtering Operator
 * 가장먼저 이벤트를 방출한 이너 옵저버블에서만 이벤트를 방출한다
 * flatMap에서 파생된 옵저버블
 * 가장 먼저 이벤트를 방출하는 옵저버블만 방출
 */

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redHeart = "❤️"
let greenHeart = "💚"
let blueHeart = "💙"

Observable.from([redCircle, greenCircle, blueCircle])
// Inner 옵저버블을 방출
    .flatMapFirst { circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable.repeatElement(redHeart) // 만약 해당 옵저버블이 먼저 방출된다면 나머지 옵저버블은 방출하지 않는다
                .take(5)
        case greenCircle:
            return Observable.repeatElement(greenHeart)
                .take(5)
        case blueCircle:
            return Observable.repeatElement(blueHeart)
                .take(5)
        default:
            return Observable.just("")
        }
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
