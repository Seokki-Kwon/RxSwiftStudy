import UIKit
import RxSwift

/*:
 ## compactMap - Transforming Operator
 * nil을 필터링하는 compactMap 연산자
*/

let disposeBag = DisposeBag()
let subject = PublishSubject<String?>()

subject
    .compactMap { $0 } // compactMap을 사용하면 필터링 언래핑과정 생략가능
//    .filter { $0 != nil }
//    .map { $0! }
    .subscribe { print($0) }
    
    .disposed(by: disposeBag)

Observable<Int>.interval(.milliseconds(300), scheduler: MainScheduler.instance)
    .take(10)
    .map { _ in Bool.random() ? "⭐️" : nil }
    .subscribe(onNext: {subject.onNext($0)})
    .disposed(by: disposeBag)
