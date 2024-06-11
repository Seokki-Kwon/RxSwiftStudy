//
//  RxCocoaTableViewViewController.swift
//  LearnRxSwift
//
//  Created by 석기권 on 6/11/24.
//

import UIKit
import RxSwift
import RxCocoa

// RxCocoa에서는 Delegate패턴을 사용하지 않는다.
class RxCocoaTableViewViewController: UIViewController {
    
    private let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let priceFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = NumberFormatter.Style.currency
        f.locale = Locale(identifier: "Ko_kr")
        
        return f
    }()
    
    let bag = DisposeBag()
    
    let nameObservable = Observable.of(appleProducts.map { $0.name })
    let productObservable = Observable.of(appleProducts)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(listTableView)
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "standardCell")
        
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        // #1
        //        nameObservable.bind(to: listTableView.rx.items) { tableView, row, element in
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "standardCell")!
        //            cell.textLabel?.text = element
        //            return cell
        //        }
        //        .disposed(by: bag)
        
        // #2
        //        nameObservable.bind(to: listTableView.rx.items(cellIdentifier: "standardCell")) { row, element, cell in
        //            cell.textLabel?.text = element
        //        }
        //        .disposed(by: bag)
        listTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "productCell")
        listTableView.rowHeight = 200
        // #3
        productObservable.bind(to: listTableView.rx.items(cellIdentifier: "productCell", cellType: ProductTableViewCell.self)) { [weak self] row, element, cell in
            cell.categoryLabel.text = element.category
            cell.productNameLabel.text = element.name
            cell.priceLabel.text = self?.priceFormatter.string(for: element.price)
            cell.summaryLabel.text = element.summary
        }
        .disposed(by: bag)
        
        
//        listTableView.rx.modelSelected(Product.self)
//            .subscribe(onNext: { product in
//                print(product.name)
//            })
//            .disposed(by: bag)
//        
//        listTableView.rx.itemSelected
//            .subscribe(onNext: { [weak self] indexPath in
//                self?.listTableView.deselectRow(at: indexPath, animated: true)
//            })
//            .disposed(by: bag)
        
        Observable.zip(listTableView.rx.modelSelected(Product.self), listTableView.rx.itemSelected)
            .bind { [weak self] (product, indexPath) in
                self?.listTableView.deselectRow(at: indexPath, animated: true)
                print(product.name)
            }
            .disposed(by: bag)
        
//        listTableView.delegate = self // 더이상 RxCocoa 구독 방출은 동작하지 않는다.
        // RxCocoa delegate 지정방법
        listTableView.rx.setDelegate(self)
            .disposed(by: bag)
    }
}

extension RxCocoaTableViewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}

class ProductTableViewCell: UITableViewCell {
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .red
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [categoryLabel, productNameLabel, summaryLabel, priceLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            productNameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            summaryLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
