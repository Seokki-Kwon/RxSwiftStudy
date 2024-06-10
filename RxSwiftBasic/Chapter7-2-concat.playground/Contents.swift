import UIKit
import RxSwift

/*:
 ## concat - Comibing Operator
 * 두개의 옵저버블을 연결
 */

let bag = DisposeBag()
let fruits = Observable.from(["🍏", "🍎", "🍋", "🍓", "🍇"])
let animals = Observable.from(["🐶", "🐱", "🐹", "🐼", "🐯"])

// 타입메서드
// 컬렉션을 연결한 하나의 옵저버블을 리턴
Observable.concat([fruits, animals])
    .subscribe { print($0) }
    .disposed(by: bag)
// 과일, 동물 방출뒤에 completed 이벤트 전달

// 인스턴스 메서드
fruits.concat(animals)
    .subscribe { print($0) }
    .disposed(by: bag)
