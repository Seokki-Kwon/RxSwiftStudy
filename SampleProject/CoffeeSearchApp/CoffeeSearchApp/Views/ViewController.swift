//
//  ViewController.swift
//  CoffeeSearchApp
//
//  Created by 석기권 on 6/13/24.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var removeButton: UIBarButtonItem!
    
    private let viewModel = CoffeeListViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        tableView.rowHeight = 140
        
        viewModel.coffeeSubject
            .bind(to: tableView.rx.items(cellIdentifier: ProductCell.identifier, cellType: ProductCell.self)) { [weak self] index, item, cell in
                cell.titleLabel.text = item.name
                cell.priceLabel.text = "\(item.price) $"
                cell.descriptionLabel.text = item.description
                cell.imageUrl = item.image_url
                cell.item = item
                
                cell.addButtonTap
                    .subscribe { item in
                        guard let item = item.element else { return }
                        self?.viewModel.addWishlist(item)
                    }
                    .disposed(by: cell.bag)
            }
            .disposed(by: bag)
                
        
        viewModel.wishlistRelay
            .map { $0.map {$0.price}.reduce(0, +)}
            .map { String(format: "%.2f", $0) }
            .map { "\($0) $"}
            .bind(to: priceLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.wishlistRelay
            .map { $0.count }
            .map { "\($0) 개 선택됨" }
            .bind(to: productCount.rx.text)
            .disposed(by: bag)
        
        removeButton.rx.tap
            .subscribe { [weak self] _ in
                self?.viewModel.removeProduct()
            }
            .disposed(by: bag)
    }
}
