import UIKit
import RxSwift

// Observable이 헷갈린다!!
// Observable은 이벤트를 방출
// Observer는 이벤트를 구독

let bag = DisposeBag()

enum MyError: Error {
    case error
}

// Observable.create로 Observable 생성
//
let o1 = Observable<Int>.create { observer in
    observer.onNext(3) // next이벤트로 3전달
    observer.onError(MyError.error)
    return Disposables.create()
}

// 단지 상홍에 따라서 구독결과를 받고싶을때 onNext, onError등을 사용
o1
    .subscribe(onNext: { num in
        print(num)
    }, onError: { error in
        print(error.localizedDescription)
    }, onCompleted: {
        print("completed!")
    })
    .disposed(by: bag)

// 그냥 모든 결과를 받는다
o1
    .subscribe { print($0) }
