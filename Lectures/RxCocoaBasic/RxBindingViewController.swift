//
//  RxBindingViewController.swift
//  LearnRxSwift
//
//  Created by 석기권 on 6/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class RxBindingViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(valueLabel)
        view.addSubview(valueField)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            valueField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            valueField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            valueField.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 10),
            valueField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // bind
//        valueField.rx.text //  ControlProperty<String?> 리턴(옵저버블)
//            .subscribe { [weak self]  str in
//                self?.valueLabel.text = str
//            }
//            .disposed(by: disposeBag)
        
        // bind 사용
        valueField.rx.text //  ControlProperty<String?> 리턴(옵저버블)
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}
