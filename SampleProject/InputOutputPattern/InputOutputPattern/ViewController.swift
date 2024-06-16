//
//  ViewController.swift
//  InputOutputPattern
//
//  Created by 석기권 on 6/15/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let nameTextField: UITextField = UITextField()
    private let emailTextField: UITextField = UITextField()
    private let confirmButton: UIButton = UIButton()
    
    let disposeBag = DisposeBag()
    var viewModel: MyViewModel = MyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        bind()
    }

    func bind() {
        // nameTextField ControlProperty를 viewModel.input.nameText(Observable)과 바인딩
        // nameTextField의 값이 변경될떄마다 input의 스트림이 변한다
        nameTextField.rx.text
            .bind(to: viewModel.input.nameText)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .bind(to: viewModel.input.emailText)
            .disposed(by: disposeBag)
        
        // combineLatest로 변화되는 스트림을 구독해서 버튼의 상태를 변경한다.
        viewModel.ouput.isConfirmEnabled
            .drive(confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

