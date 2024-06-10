import UIKit
import RxSwift

/*:
 ## FlatMap - Transforming Operator
 * Inner Obesrvable
 * Flatining Observable
 */

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redHeart = "❤️"
let greenHeart = "💚"
let blueHeart = "💙"

// Observable이 방출하는 항목을 Inner Observable을 통해서 평탄화하는 작업?
Observable.from([redCircle, greenCircle, blueCircle])
// Inner 옵저버블을 방출
    .flatMap { circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable.repeatElement(redHeart)
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
    .subscribe { print($0) }  // 하나의 result 옵저저블로 방출
    .disposed(by: disposeBag)
