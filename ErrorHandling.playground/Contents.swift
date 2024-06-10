import UIKit
import RxSwift

/*:
 ## catch
 * Observable 또는 defaultValue 방출
 * 기본값 또는 로컬캐시 사용
 */

let bag = DisposeBag()

enum MyError: Error {
    case error
}

//let subject = PublishSubject<Int>()
//let recovery = PublishSubject<Int>()
//
//subject
//    .catch { _ in recovery } // 원본 suject를 recover로 변경
//    .subscribe { print($0) }
//    .disposed(by: bag)
//
//subject.onError(MyError.error)
//subject.onNext(123) // 더이상 전달되지 않는다.
//recovery.onNext(22)
//
//
//subject
//    .catchAndReturn(-1) // 원본 suject를 recover로 변경
//    .subscribe { print($0) }
//    .disposed(by: bag)
//
//subject.onError(MyError.error)

// 정리
// catch 에러유형에 따라서 recover에 다른값(디폴트값, 로컬캐시값)을 리턴가능
// catchAndReturn 동일한 값을 리턴할떄


/*:
 ## retry
 * 옵저버블에대한 새로운 구독을 시작
 * retry(무한히 또는 정해진 횟수만큼), retryWhen(트리거가 이벤트를 방출하는 시점에)
 */

var attempts = 1

let source = Observable<Int>.create { observer in
    let currentAttempts = attempts
    print("#\(currentAttempts) START")
    
    if attempts < 3 {
        observer.onError(MyError.error)
        attempts += 1
    }
    
    observer.onNext(1)
    observer.onNext(2)
    observer.onCompleted()
    
    return Disposables.create {
        print("#\(currentAttempts) END")
    }
}

// 재시도 횟수는 항상 1을더하여 설정(첫시도는 재시도가 아님)
let trigger = PublishSubject<Void>()

// retry
//source
//    .retry(7)
//    .subscribe { print($0) }
//    .disposed(by: bag)


// retryWhen
source
    .retry(when: { _ in trigger })
    .subscribe { print($0) }
    .disposed(by: bag)


trigger.onNext(())


