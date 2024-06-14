//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    let viewModel = MenuListViewModel()
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        
        viewModel.menuObservable
            .bind(to: tableView.rx.items(cellIdentifier: "MenuItemTableViewCell", cellType: MenuItemTableViewCell.self)) { index, item, cell in
                cell.title.text = item.name
                cell.count.text = "\(item.count)"
                cell.price.text = "\(item.price)"
                
                cell.onChanged = { [weak self] increase in
                    self?.viewModel.changeCountItem(item: item, increase: increase)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.itemsCount
            .map { "\($0)"}
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalPrice
            .map { $0.currencyKR() }
            .bind(to: totalPrice.rx.text)
            .disposed(by: disposeBag)
    }
    
    func updateUI() {
        itemCountLabel.text = "\(viewModel.itemsCount)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "OrderViewController",
           let orderVC = segue.destination as? OrderViewController {
            // TODO: pass selected menus
        }
    }
    
    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - InterfaceBuilder Links
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!
    
    @IBAction func onClear() {
        viewModel.clearItemSelections()
    }
    
    @IBAction func onOrder(_ sender: UIButton) {
        // TODO: no selection
        // showAlert("Order Fail", "No Orders")
        //        performSegue(withIdentifier: "OrderViewController", sender: nil)
        
        viewModel.menuObservable.onNext([
            Menu(id: 0, name: "changed", price: Int.random(in: 100...1000), count: Int.random(in: 1...5)),
            Menu(id: 1, name: "changed", price: Int.random(in: 100...1000), count: Int.random(in: 1...5)),
            Menu(id: 2, name: "changed", price: Int.random(in: 100...1000), count: Int.random(in: 1...5)),
        ])
    }
}

