import UIKit
import RxSwift

/*:
 ## multicast
 * 특정시점에 같은 시퀀스를 공유할 수 있다
 */

let bag = DisposeBag()
let subject = PublishSubject<Int>()

let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(5)
    .multicast(subject) // ConnectableObservable이 저장됨

source
    .subscribe { print("🔵", $0)}
    .disposed(by: bag)

source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance) // 구독시점을 3초 지연
    .subscribe { print("🔴", $0)}
    .disposed(by: bag)

source.connect() // connect를 명시적으로 호출해야 시퀀스가 시작됨

/**
 public func multicast<Subject: SubjectType>(_ subject: Subject)
     -> ConnectableObservable<Subject.Element> where Subject.Observer.Element == Element {
     ConnectableObservableAdapter(source: self.asObservable(), makeSubject: { subject })
 }
 */
// Observable: 구독자가 추가되는 시점에 시퀀스가 시작
// ConnectableObservable: 구독자가 추가되어도 시작되지않고 connet가 호출되는 순간에 시퀀스 시작
// ConnectableObservableAdapter: 원본 Observable과 subject를 연결해주는 클래스
