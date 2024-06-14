//
//  ProductCell.swift
//  CoffeeSearchApp
//
//  Created by 석기권 on 6/14/24.
//

import UIKit
import RxCocoa
import RxSwift

class ProductCell: UITableViewCell {
    static let identifier = "ProductCell"
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    var bag = DisposeBag()
    private var addButtonTapSubject = PublishSubject<Coffee>()
    public var item: Coffee?
    
    var addButtonTap: Observable<Coffee> {
        return addButtonTapSubject.asObserver()
    }
    
    public var imageUrl: String? {
        didSet {
            productImage.load(url: URL(string: imageUrl ?? "")!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addButtonTap(_ sender: Any) {
        guard let item = item else { return }
        self.addButtonTapSubject.onNext(item)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
}
