import UIKit
import RxSwift

let disposeBag = DisposeBag()

Observable.just("Hello RxSwift")
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// 명령형 코드
//var a = 1
//var b = 2
//a + b // 결과는 바뀌지 않는다 3출력
//
//a = 12
//
//// rxSwift로 작성
//// Reactive Programing 

let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

Observable.combineLatest(a, b) { $0 + $1 }
    .subscribe(onNext: {print($0)})
    .disposed(by: disposeBag)

a.onNext(12) // a의 값을 변경 14출력

