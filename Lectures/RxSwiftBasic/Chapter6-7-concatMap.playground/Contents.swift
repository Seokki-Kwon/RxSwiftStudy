import UIKit
import RxSwift

/*:
 ## concatMap - Transforming Operator
 * Interleaving을 허용하지 않는다
 */

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redHeart = "❤️"
let greenHeart = "💚"
let blueHeart = "💙"


Observable.from([redCircle, greenCircle, blueCircle])
// 방출 순서를 보장
    .concatMap { circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable.repeatElement(redHeart) // 이벤트 방출끝나면 다음 이벤트로
                .take(5)
        case greenCircle:
            return Observable.repeatElement(greenHeart)// 이벤트 방출끝나면 다음 이벤트로
                .take(5)
        case blueCircle:
            return Observable.repeatElement(blueHeart) // 이벤트 방출끝나면 다음 이벤트로
                .take(5)
        default:
            return Observable.just("")
        }
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

