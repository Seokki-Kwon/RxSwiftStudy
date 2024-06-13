import UIKit
import RxSwift

let disposeBag = DisposeBag()
let element = "❤️"

Observable.repeatElement(element)
    .take(7) // take로 지정된 수만큼 방출되도록 설정
    .subscribe { print($0) }
    .disposed(by: disposeBag)
