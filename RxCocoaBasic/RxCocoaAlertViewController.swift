//
//  RxCocoaAlertViewController.swift
//  LearnRxSwift
//
//  Created by 석기권 on 6/12/24.
//

import UIKit
import RxSwift
import RxCocoa

class RxCocoaAlertViewController: UIViewController {
    let bag = DisposeBag()
    private lazy var colorView: UIView = {
        let view = UIView(frame: CGRect(x: view.center.x / 2, y: 150, width: 200, height: 200))
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var oneActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("AlertView - One Actions", for: .normal)
        return button
    }()
    
    private lazy var twoActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("AlertView - Two Actions", for: .normal)
        return button
    }()
    
    private lazy var multipleActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("AlertView - Multiple Actions", for: .normal)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        [oneActionButton, twoActionButton, multipleActionButton].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(colorView)
        view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        oneActionButton.rx.tap
            .flatMap { [unowned self] in self.info(title: "Current Color", message: "message")}
            .subscribe(onNext: { actionType in
                switch actionType {
                case .ok:
                    print("ok")
                default:
                    break
                }
            })
            .disposed(by: bag)
        
        twoActionButton.rx.tap
            .flatMap { [unowned self] in self.alert(title: "Background Change", message: "Change")}
            .subscribe(onNext: { [unowned self] actionType in
                switch actionType {
                case .ok:
                    colorView.backgroundColor = .black
                case .cancle:
                    break
                }
            })
            .disposed(by: bag)
        
        multipleActionButton.rx.tap
            .flatMap { [unowned self] in self.colorActionSheet(colors: [.red, .blue, .brown], title: "컬러선택")}
            .subscribe { [unowned self] color in
                self.colorView.backgroundColor = color
            }
            .disposed(by: bag)
    }
}

enum ActionType {
    case ok
    case cancle
}
extension UIViewController {
    // Observable<ActionType>을 리턴하는 함수구현
    func info(title: String, message: String? = nil) -> Observable<ActionType> {
        Observable.create { [weak self] observer in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                observer.onNext(.ok)
                observer.onCompleted()
            }
            
            alert.addAction(okAction)
            
            self?.present(alert, animated: true, completion: nil)
            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func alert(title: String, message: String? = nil) -> Observable<ActionType> {
        Observable.create { [weak self] observer in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                observer.onNext(.ok)
                observer.onCompleted()
            }
            
            let cancleAction = UIAlertAction(title: "Cancle", style: .cancel) { _ in
                observer.onNext(.cancle)
                observer.onCompleted()
            }
            
            alert.addAction(okAction)
            alert.addAction(cancleAction)
            
            self?.present(alert, animated: true, completion: nil)
            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func colorActionSheet(colors: [UIColor], title: String, message: String? = nil) -> Observable<UIColor> {
        return Observable.create { [weak self] observer in
            let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            for color in colors {
                let colorAction = UIAlertAction(title: "컬러", style: .default) { _ in
                    observer.onNext(color)
                }
                actionSheet.addAction(colorAction)
            }
            
            let cancleAction = UIAlertAction(title: "Cancle", style: .cancel) { _ in
                observer.onCompleted()
            }
            actionSheet.addAction(cancleAction)
            
            self?.present(actionSheet, animated: true, completion: nil)
            
            return Disposables.create {
                print("dispose")
                actionSheet.dismiss(animated: true, completion: nil)
            }
        }
    }
}
