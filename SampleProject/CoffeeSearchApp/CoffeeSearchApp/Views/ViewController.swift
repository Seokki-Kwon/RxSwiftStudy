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
    private let viewModel = CoffeeListViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        tableView.rowHeight = 140
        
        viewModel.coffeeSubject
            .bind(to: tableView.rx.items(cellIdentifier: ProductCell.identifier, cellType: ProductCell.self)) {index, item, cell in
                cell.titleLabel.text = item.name
                cell.priceLabel.text = "\(item.price) $"
                cell.descriptionLabel.text = item.description
                cell.imageUrl = item.image_url
            }
            .disposed(by: bag)
    }
}

