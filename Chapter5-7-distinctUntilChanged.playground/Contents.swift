import UIKit
import RxSwift

//// distinctUntilChanged - 동일한 요소가 방출되지 않도록
//let disposeBag = DisposeBag()
//let numbers = [1, 1, 3, 2, 2, 3, 1, 5, 5, 7, 7]
//
//Observable.from(numbers)
//    .distinctUntilChanged()
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)
//// 동일한 요소가 방출되지 않도록함 연속되지 않는경우 동일한 요소를 방출함
//// 1, 3, 2, 3, 1, 5, 7
//
struct Person {
    let name: String
    let age: Int
}

let disposeBag = DisposeBag()
let numbers = [1, 1, 3, 2, 2, 3, 1, 5, 5, 7, 7, 7]
let tuples = [(1, "하나"), (1, "일"), (1, "one")]
let persons = [
    Person(name: "Sam", age: 12),
    Person(name: "Paul", age: 12),
    Person(name: "Tim", age: 56)
]

// 파라미터가 없는경우
//Observable.from(numbers)
//    .distinctUntilChanged()
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)

// 직접구현
//Observable.from(numbers)
//    .distinctUntilChanged { !$0.isMultiple(of: 2) && !$1.isMultiple(of: 2) } // 값이 홀수면 같은값으로 판단
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)

// 비교값이 Equatable을 채택한 값이여야함
Observable.from(tuples)
    .distinctUntilChanged { $0.1 } // $0.0 -> 연속값제거 $0.1 -> 모두출력
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// keyPath사용
Observable.from(persons)
    .distinctUntilChanged(at: \.age) // age속성을 전달받음 Paul은 출력되지 않는다.
    .subscribe { print($0) }
    .disposed(by: disposeBag)





