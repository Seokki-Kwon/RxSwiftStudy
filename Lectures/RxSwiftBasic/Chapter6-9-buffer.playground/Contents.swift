import UIKit
import RxSwift

/*:
 ## buffer - Trainsforming Operator
 * 옵저버블이 방출하는 이벤트를 수집하고 하나의 배열로 리턴
 * Controlled Buffering
 */

let disposeBag = DisposeBag()
// count는 MaximumElement의 개념
// 5초가 경과하기전에 3개가 수집되면 방출
// 5초가 지났는데 3개가 수집되지 않아도 방출
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .buffer(timeSpan: .seconds(5), count: 3, scheduler: MainScheduler.instance) // 2초마다 수집
    .take(5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
