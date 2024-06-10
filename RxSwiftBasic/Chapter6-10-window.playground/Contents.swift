import UIKit
import RxSwift

/*:
 ## window - Transforming Operator
 * buffer처럼 timeSpan과 max값을 적용
 * 배열대신 옵저버블을 리턴(buffer와의 차이)
 
 ### InnerObservable
 > Observable을 방출하는 Observable
 지정된 시간이 경과화면 Complted 방출하고 종료
 */

let disposeBag = DisposeBag()

// AddRef<Swift.Int>를 방출한다.
// AddRef는 구독할 수 있는 옵저버블 형태
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .window(timeSpan: .seconds(2), count: 3, scheduler: MainScheduler.instance)
    .take(5) // 5번만 수행
    .subscribe { print($0)
        // 2초가 지나면 수집된 이벤트를 옵저버블 형태로 방출
        if let observable = $0.element {
            observable.subscribe { print("inner: ", $0) }
        }
    }
    .disposed(by: disposeBag)

