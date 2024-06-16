//
//  MyViewModel.swift
//  InputOutputPattern
//
//  Created by 석기권 on 6/15/24.
//

import Foundation
import RxSwift
import RxCocoa

final class MyViewModel: ViewModelType {
    struct Dependency {
        var name: String?
        var email: String?
    }
    
    struct Input {
        var nameText: AnyObserver<String?>
        var emailText: AnyObserver<String?>
    }
    
    struct Output {
        var isConfirmEnabled: Driver<Bool>
    }
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let ouput: Output
    
    private let nameText$: BehaviorSubject<String?>
    private let emailText$: BehaviorSubject<String?>
    
    // Dependency(name: nil, email: nil) 스트림 생성과관리
    init(dependency: Dependency = Dependency(name: nil, email: nil)) {
        self.dependency = dependency
        
        let nameText$ = BehaviorSubject<String?>(value: nil)
        let emailText$ = BehaviorSubject<String?>(value: nil)
        let isConfirmEnabled$ = Observable.combineLatest(nameText$, emailText$)
            .map(validation)
            .asDriver(onErrorJustReturn: false)
        
        self.input = Input(nameText: nameText$.asObserver(), emailText: emailText$.asObserver())
        self.ouput = Output(isConfirmEnabled: isConfirmEnabled$)
        
        self.nameText$ = nameText$
        self.emailText$ = emailText$
    }
}
private func validation(name: String?, email: String?) -> Bool {
    return name?.isEmpty == false && email?.isEmpty == false
}
