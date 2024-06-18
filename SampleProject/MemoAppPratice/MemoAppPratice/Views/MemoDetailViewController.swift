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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    
    func bindViewModel() {
        viewModel.memoTitleObservable
            .bind(to: titleLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.memoContentObservable
            .bind(to: contentLabel.rx.text)
            .disposed(by: bag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
