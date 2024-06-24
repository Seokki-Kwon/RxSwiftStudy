import UIKit
import RxSwift

let bag = DisposeBag()
//  Observable을 리턴
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().share()

let observer1 = source
    .subscribe { print("🔵", $0) }

let observer2 = source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print("🔴", $0) }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    observer1.dispose()
    observer2.dispose()
    // Dispose
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    // 새로운 시퀀스 시작 0부터 시작
    let observer3 = source.subscribe { print("⚫️", $0) }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        observer3.dispose()
    }
}

/**
 public func share(replay: Int = 0, scope: SubjectLifetimeScope = .whileConnected)
     -> Observable<Element> {
     switch scope {
     case .forever:
         switch replay {
         case 0: return self.multicast(PublishSubject()).refCount()
         default: return self.multicast(ReplaySubject.create(bufferSize: replay)).refCount()
         }
     case .whileConnected:
         switch replay {
         case 0: return ShareWhileConnected(source: self.asObservable())
         case 1: return ShareReplay1WhileConnected(source: self.asObservable())
         default: return self.multicast(makeSubject: { ReplaySubject.create(bufferSize: replay) }).refCount()
         }
     }
 }
 */
// replay에 따라서 bufferSize 결정
// forever는 같은 Subject를 공유한다.
// whileConnected는 연결동안의 Subject를 공유 Dispose 되는경우 새로운 시퀀스를 시작
