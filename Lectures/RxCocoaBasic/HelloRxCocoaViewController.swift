//
//  HelloRxCocoaViewController.swift
//  LearnRxSwift
//
//  Created by 석기권 on 6/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class HelloRxCocoaViewController: UIViewController {
    let bag = DisposeBag()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var tapButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Tap", for: .normal)
        bt.backgroundColor = .red
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(valueLabel)
        view.addSubview(tapButton)
        
        valueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tapButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        view.backgroundColor = .systemBackground
        
        tapButton.rx.tap
            .map { "Hello RxCocoa" }
//            .subscribe { [weak self] str in
//                self?.valueLabel.text = str
//            }
            .bind(to: valueLabel.rx.text)
            .disposed(by: bag)
    }
}


class Test: NSObject {
    
}
