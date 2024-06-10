import UIKit
import RxSwift

/*:
 ## map - Transforming Operator
* 원본 옵저버블이 방출하는 요소를 대상으로 함수를 실행하고 새로운 옵저버블 리턴

*/

let disposeBag = DisposeBag()
let skills = ["Swift", "SwiftUI", "RxSwift"]

Observable.from(optional: skills)
    .map {"Hello \($0)"}
    .subscribe { print($0) }
    .disposed(by: disposeBag)

Observable.from(optional: skills)
    .map { $0.count } // 클로저가 리턴하는 타입은 상관없음
    .subscribe { print($0) }
    .disposed(by: disposeBag)

