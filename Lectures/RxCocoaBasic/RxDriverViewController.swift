//
//  RxDriverViewController.swift
//  LearnRxSwift
//
//  Created by 석기권 on 6/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class RxDriverViewController: UIViewController {
    let bag = DisposeBag()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        return textField
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        label.backgroundColor = .blue
        return label
    }()
    
    private let sendBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("send", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(textField)
        view.addSubview(resultLabel)
        view.addSubview(sendBtn)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            resultLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            
            sendBtn.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 30),
            sendBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // driver 미사용
//        let result = textField.rx.text
//            .flatMapLatest {
//                self.validateText($0)
//                    .observe(on: MainScheduler.instance)
//                .catchAndReturn(false) }
//            .share() // 같은 시퀀스를 공유하도록
        
        // driver 사용
        let result = textField.rx.text.asDriver()
            .flatMapLatest {
                self.validateText($0)
                    .asDriver(onErrorJustReturn: false)
            }
            
        result
            .map { $0 ? "OK" : "Error"}
            .drive(resultLabel.rx.text)
            .disposed(by: bag)
        
        result
            .map { $0 ? UIColor.blue : UIColor.red}
            .drive(resultLabel.rx.backgroundColor)
            .disposed(by: bag)
        
        result
            .drive(sendBtn.rx.isEnabled)
            .disposed(by: bag)
        
    }
    
    enum ValidateError: Error {
        case notANumber
    }
    
    func validateText(_ value: String?) -> Observable<Bool> {
        return Observable.create { observer in
            print("== \(value ?? "") Sequence Start ==")
            
            defer {
                print("== \(value ?? "") Sequence End ==")
            }
            guard let str = value, let _ = Double(str) else {
                observer.onError(ValidateError.notANumber)
                return Disposables.create()
            }
            
            observer.onNext(true)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
