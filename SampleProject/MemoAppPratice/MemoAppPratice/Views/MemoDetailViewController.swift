//
//  MemoDetailViewController.swift
//  MemoAppPratice
//
//  Created by 석기권 on 6/18/24.
//

import UIKit
import RxSwift
import RxCocoa

class MemoDetailViewController: UIViewController, BindableType {
    var viewModel: MemoDetailViewModel!
    let bag = DisposeBag()
    

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentLabel: UITextView!
    @IBOutlet weak var editButton: UIButton!
    
    func bindViewModel() {
        // 변경된 메모내용 -> UI에 바인딩
        viewModel.memoSubject
            .withUnretained(self)
            .subscribe { (vc, values) in
                vc.titleTextField.text = values[0]
                vc.contentLabel.text = values[1]
            }
            .disposed(by: bag)
        
        // 내용입력 -> BehaviorRelay 업데이트
        contentLabel.rx.text.orEmpty
            .withUnretained(self)
            .subscribe(onNext: { (vc, event) in
                vc.viewModel.updateContent(content: event)
            })
            .disposed(by: bag)
        
        titleTextField.rx.text.orEmpty
            .withUnretained(self)
            .subscribe { (vc, event) in
                vc.viewModel.updateTitle(title: event)
            }
            .disposed(by: bag)
        
        // editMode에 따라서 isUserIteractionEable, text 값 변화
        viewModel.editModeSubject
            .bind(to: contentLabel.rx.isUserInteractionEnabled)
            .disposed(by: bag)
        
        viewModel.editModeSubject
            .bind(to: titleTextField.rx.isEnabled)
            .disposed(by: bag)
        
        // 수정이 완료되면 -> 변경된 내용을 업데이트
        // 수정을 하려고하면 -> 텍스트 변경 값바디인딩
        viewModel.editModeSubject
            .withUnretained(self)
            .do(onNext: { (vc, editMode) in
                if !editMode {
                    vc.viewModel.performUpdate()
                }
            })
            .map { $1 ? "수정 완료" : "메모 수정"}
            .bind(to: editButton.rx.title())
            .disposed(by: bag)
        
        // editMode 바인딩
        editButton.rx.tap
            .scan(false) { lastState, newState in !lastState }
            .bind(to: viewModel.editModeSubject)
            .disposed(by: bag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
