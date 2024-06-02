import UIKit
import RxSwift

let disposeBag = DisposeBag()
let animals = ["🐶", "🙊", "🐷", "🐯", "🐥", "🐻", "🦊"]
let fruits = ["🍎", "🍐", "🍋", "🍇", "🍈", "🍓", "🍑"]
var flag = true

// deferred
// 특정 조건에 따라 옵저버블 생성
let factory: Observable<String> = Observable.deferred {
    flag.toggle()
    if flag {
        return Observable.from(animals)
    } else {
        return Observable.from(fruits)
    }
}

factory
    .subscribe { print($0) }
    .disposed(by: disposeBag)

factory
    .subscribe { print($0) }
    .disposed(by: disposeBag)


