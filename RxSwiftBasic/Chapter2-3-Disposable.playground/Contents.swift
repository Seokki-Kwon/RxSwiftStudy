import UIKit
import RxSwift

// Disposed
// 모든 리소스가 정리된후에 호출됨
let subscription1 = Observable.from([1, 2, 3])
    .subscribe(onNext: { elem in
        print("Next", elem)
    }, onError: { error in
        print("Error", error)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: {
        print("Disposed")
    })

//subscription1.dispose() // 리소스해제

var bag = DisposeBag() // dispose보다 DisposeBag 사용을 추천

// Disposed 호출되지 않는다.
// 호출되지 않는다고해서 리소스가 정리되지않은것은 아니다
Observable.from([1, 2, 3])
    .subscribe {
        print($0)
    }
    .disposed(by: bag) // disposeBag에 담김

bag = DisposeBag() // 이전의 disposeBag 해제

let subscription2 = Observable<Int>.interval (.seconds(1),
                                              scheduler: MainScheduler.instance)
    .subscribe(onNext: { elem in
        print("Next", elem)
    }, onError: { error in
        print("Error", error)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: {
        print("Disposed")
    })

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    subscription2.dispose()
}
