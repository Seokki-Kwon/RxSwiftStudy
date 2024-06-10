import UIKit
import RxSwift

/*:
 ## merger - Combining Operator
 * 여러 옵저버블이 방출하는 이벤트를 하나의 옵저버블에서 방출하도록 병합
 */
let bag = DisposeBag()

enum MyError: Error {
    case error
}

let oddNumbers = BehaviorSubject(value: 1)
let evenNumbers = BehaviorSubject(value: 2)
let negativeNumbers = BehaviorSubject(value: -1)

// concat은 하나의 옵저버블이 모든 요소를 방출하고 completed방출
// 2개 이상의 옵저버블을 병합하고 모든 요소를 순서대로 방출

let source = Observable.of(oddNumbers, evenNumbers, negativeNumbers)

source
    .merge(maxConcurrent: 2) // 2개의 서브젝트를 병합한 옵저버블을 리턴(negativewNubmers는 무시됨)
    .subscribe { print($0) }// next(1), next(2) 2개의 서브젝트가 아닌 2개의 서브젝트의 넥스트값이 전달됨
    .disposed(by: bag)

oddNumbers.onNext(3) // 3전달
evenNumbers.onNext(4) // 4전달

evenNumbers.onNext(6)
oddNumbers.onNext(5)

// 종료시점
oddNumbers.onCompleted() // oddNumbers의 이벤트를 더이상 받지않음
//oddNumbers.onError(MyError.error) // 에러가 방출되면 모든 이벤트는 더이상 방출되지 않는다.
evenNumbers.onNext(8)
oddNumbers.onNext(44) // 전달안됨

evenNumbers.onCompleted()
