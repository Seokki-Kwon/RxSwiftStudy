import UIKit
import RxSwift

// Observable <- Observer - subscribe(구독)
// Observable -> Observer - emssion

// Observable
// 이벤트가 전달되는 방식을 정의
// Observable 동작 직접구현(create)

// #1
let o1 = Observable<Int>.create { (observer) -> Disposable in
    observer.on(.next(0))
    observer.onNext(1) // 1이 저장된 next이벤트 전달
    observer.onCompleted() // 완료전달
    
    return Disposables.create() // Disposable은 메모리정리에 필요한 객체
}

// #2
// from
// 파라미터에 전달된 배열의 요소를 순서대로 방출
// 순서대로 값을 방출할때는 create보다는 from이 유용하다
Observable.from([0, 1])

// 여기까지는 Observable만 생성된상태
// 값을 받으려면 subscribe 해야함
// Observable은 이벤트를 동시에 처리하지 않는다.
o1.subscribe {
    print("== Start ==")
    print($0)
    
    if let elem = $0.element {
        print(elem)
    }
    print("== End ==")
}

print("---------------------")

//o1.subscribe(onNext: {elem in
//        print(elem)
//})



