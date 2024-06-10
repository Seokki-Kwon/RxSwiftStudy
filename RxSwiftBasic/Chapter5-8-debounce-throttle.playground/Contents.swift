import UIKit
import RxSwift

// debounce, throttle - 짦은시간동안 반복적으로 방출되는 이벤트를 제어

// debounce
let disposeBag = DisposeBag()
//
//let buttonTap = Observable<String>.create { observer in
//    DispatchQueue.global().async {
//        // 1...10까지 0.3 주기로 방출
//        for i in 1...10 {
//            observer.onNext("Tap \(i)")
//            Thread.sleep(forTimeInterval: 0.3)
//        }
//        
//        // 1초쉬기
//        Thread.sleep(forTimeInterval: 1)
//        
//        // 11...20 까지 0.5주기로 방출
//        for i in 11...20 {
//            observer.onNext("Tap \(i)")
//            Thread.sleep(forTimeInterval: 0.5)
//        }
//        observer.onCompleted()
//    }
//    
//    return Disposables.create {
//        
//    }
//}
//
//// 지정된 시간동안 새이벤트가 방출되지 않으면 가장 마지막에 방출된 이벤트를전달
//buttonTap
//    .debounce(.milliseconds(1000), scheduler: MainScheduler.instance) // 2개의 next이벤트만 방출
//    .subscribe { print($0)}
//    .disposed(by: disposeBag)

// 1초동안 새로운이벤트가 방출되지않는경우 무시
// Tap1 -> 타이머 1초로 초기화
// Tap2 -> 타이머 1초로 초기화
// Tap3 -> 타이머 1초로 초기화
// ...
// Tap10 -> 타이머 1초로 초기화
// Thread.sleep -> 1초경과 가장 마지막 이벤트인 Tap10 방출

// throttle
// latest -> 주기를 엄격하게 지키는가?


let buttonTap2 = Observable<String>.create { observer in
    DispatchQueue.global().async {
        // 1...10까지 0.3 주기로 방출
        for i in 1...10 {
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.3)
        }
        
        // 1초쉬기
        Thread.sleep(forTimeInterval: 1)
        
        // 11...20 까지 0.5주기로 방출
        for i in 11...20 {
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.5)
        }
        observer.onCompleted()
    }
    
    return Disposables.create {
        
    }
}

buttonTap2
    .throttle(.milliseconds(1000), latest: true, scheduler: MainScheduler.instance)
    .subscribe { print($0)}
    .disposed(by: disposeBag)

// 1초마다 방출된 이벤트를 전달

// debounce, throttle 차이
// throttle -> 주기마다 전달(탭, 델리게이트 이벤트)
// debounce -> 지정된 시간동안 next가 전달되지 않는경우 마지막 이벤트를 방출(검색 기능)

// letest true -> 주기를 엄격하게 지킴
// latest false -> 주기를 초과할 수 있음



