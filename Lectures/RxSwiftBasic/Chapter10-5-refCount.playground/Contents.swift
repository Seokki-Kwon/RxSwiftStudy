import UIKit
import RxSwift

let bag = DisposeBag()
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(5)
    .debug()
    .publish()
    .refCount() // ConnectableObservable을 유지하면서 새로운 구독자가 생성되면 connect

let observer1 = source
    .subscribe { print("🔵", $0) }

//source.connect()

// 3초뒤에 구독중지
DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    observer1.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    let observer2 = source.subscribe { print("🔴", $0) }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        observer2.dispose()
    }
}


