import UIKit
import RxSwift

/*:
 ## SharingSubscription
 * 구독을 여러번 하게될경우 발생할 불필요한 리소스가 낭비됨
 * share 연산자를 사용하여 시퀀스를 중복생성을 방지한다.
 */

let bag = DisposeBag()

let sources = Observable<String>.create { observer in
    let url = URL(string: "https://kxcoding-study.azurewebsites.net/api/string")!
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data, let html = String(data: data, encoding: .utf8) {
            observer.onNext(html)
        }
        observer.onCompleted()
    }
    task.resume()
    
    return Disposables.create {
        task.cancel()
    }
}
.debug()
.share()

// 구독자가 추가될때마다 새로운 시퀀스를 시작 -> 클라이언트에서 불필요한 리소스가 낭비됨
// 모든 구독자가 하나의 구독을 공유하도록 구현해야함
sources.subscribe().disposed(by: bag)

// share를 사용한경우 공유할 구독이 있기때문에 새로운 시퀀스를 시작하지 않는다.
sources.subscribe().disposed(by: bag)
sources.subscribe().disposed(by: bag)


