//
//  MemoListViewController.swift
//  MemoAppPratice
//
//  Created by 석기권 on 6/17/24.
//

import UIKit
import RxSwift
import RxCocoa

class MemoListViewController: UIViewController, BindableType {
    var viewModel: MemoListViewModel!
    private let bag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.rowHeight = 180
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        viewModel.memos
            .bind(to: tableView.rx.items(cellIdentifier: MemoTableViewCell.reuseIdentifier, cellType: MemoTableViewCell.self)) {row, memo, cell in
                cell.titleLabel.text = memo.title
                cell.contentLabel.text = memo.content                
            }
            .disposed(by: bag)
        
        tableView.rx.modelSelected(Memo.self)
            .subscribe { memo in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)                
                guard var memoDetailVC = storyboard.instantiateViewController(withIdentifier: "MemoDetail") as? MemoDetailViewController else {
                    fatalError()
                }
                memoDetailVC.bind(viewModel: MemoDetailViewModel(memo: memo, storage: self.viewModel.storage))
                
                self.navigationController?.pushViewController(memoDetailVC, animated: true)
            }
            .disposed(by: bag)
    }
}
