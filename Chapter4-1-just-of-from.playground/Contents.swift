import UIKit
import RxSwift

let disposeBag = DisposeBag()
let element = "😀"

// Just
// 1개의 항목을 방출하는 Observable 생성하는 타입메서드
Observable.just(element)
    .subscribe { event in print(event) }
    .disposed(by: disposeBag)

Observable.just([1, 2, 3])
    .subscribe { event in print(event) }
    .disposed(by: disposeBag)

// of
// 2개이상의 요소를 방출
let apple = "🍏"
let orange = "🍊"
let kiwi = "🥝"
Observable.of(apple, orange, kiwi)
    .subscribe { event in print(event) }
    .disposed(by: disposeBag)

Observable.of([1, 2], [3, 4], [5, 6])
    .subscribe { event in print(event) }
    .disposed(by: disposeBag)
// [1, 2] [3, 4] [5, 6]

// 배열의 요소를 순서대로 방출하고싶은 경우
let fruits = ["🍏", "🍎", "🍋", "🍓", "🍇"]
Observable.from(fruits)
    .subscribe { event in print(event) }
    .disposed(by: disposeBag)
