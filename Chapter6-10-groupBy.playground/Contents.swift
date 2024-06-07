import UIKit
import RxSwift

/*:
 ## groupBy - Transforming Operator
 * 방출되는 요소를 조건을 원하는 기준으로 그룹핑
 
 ```
 public func groupBy<Key: Hashable>(keySelector: @escaping (Element) throws -> Key)
     -> Observable<GroupedObservable<Key, Element>> {
     GroupBy(source: self.asObservable(), selector: keySelector)
 }
 ```
 클로저는 요소를 파라미터로 받아서 Key를 리턴 Key는 Hashable프로토콜을 채택
 
 Observable<GroupedObservable<Key, Element>> 리턴
 */

let disposeBag = DisposeBag()
let words = ["Apple", "Banana", "Orange", "Book", "City", "Axe"]

// 4개의 그룹이 방출됨 -> 문자열의 개수로 그룹을 나눔
Observable.from(words)
    .groupBy { $0.count }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

