import UIKit
import RxSwift

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// ReplaySubject
// 2개이상의 이벤트를 저장했다가 구독자에게 전달
// 지정된 버퍼크기만큼 최신의 이벤트를 전달
// 메모리에 저장하기 떄문에 유의

let rs = ReplaySubject<Int>.create(bufferSize: 3) // 3개의 이벤트를 저장하는 버퍼생성

(1...10).forEach { rs.onNext($0) } // 10개의 이벤트 전달

rs.subscribe { print("Observer 1>>", $0) } // 마지막 3개의 이벤트만받는다.
    .disposed(by: disposeBag)

rs.subscribe { print("Observer 2>>", $0) } // 마지막 3개의 이벤트만받는다.
    .disposed(by: disposeBag)

rs.onNext(11)

rs.subscribe { print("Observer 3>>", $0) } // 마지막 3개의 이벤트만받는다.
    .disposed(by: disposeBag)

rs.onCompleted() // 3개의 구독자에게 Completed이벤트 전달
rs.onError(MyError.error)

rs.subscribe { print("Observer 4>>", $0) } // 마지막 3개의 이벤트만받는다.
    .disposed(by: disposeBag)



