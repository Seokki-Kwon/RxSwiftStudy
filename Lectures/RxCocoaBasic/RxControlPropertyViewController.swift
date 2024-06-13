//
//  RxControlPropertyViewController.swift
//  LearnRxSwift
//
//  Created by 석기권 on 6/11/24.
//

import UIKit
import RxCocoa
import RxSwift

// resetButton.rx.tap  ControlEvent: ObservableType
// Observer의 역할은 수행불가
// next, completed만 전달

class RxControlPropertyViewController: UIViewController {
    private let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    private let redSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let greenSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let blueSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("reset", for: .normal)
        return button
    }()
    
    private let redComponentLabel: UILabel = {
        let label = UILabel()
//        label.text = "0"
        return label
    }()
    
    private let greenComponentLabel: UILabel = {
        let label = UILabel()
//        label.text = "0"
        return label
    }()
    
    private let blueComponentLabel: UILabel = {
        let label = UILabel()
//        label.text = "0"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        [redComponentLabel, greenComponentLabel, blueComponentLabel].forEach { stackView.addArrangedSubview($0)}
        return stackView
    }()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(colorView)
        view.addSubview(redSlider)
        view.addSubview(greenSlider)
        view.addSubview(blueSlider)
        view.addSubview(resetButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 200),
            
            redSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redSlider.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 20),
            redSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            redSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            greenSlider.leadingAnchor.constraint(equalTo: redSlider.leadingAnchor),
            greenSlider.trailingAnchor.constraint(equalTo: redSlider.trailingAnchor),
            greenSlider.topAnchor.constraint(equalTo: redSlider.bottomAnchor, constant: 20),
            
            blueSlider.leadingAnchor.constraint(equalTo: redSlider.leadingAnchor),
            blueSlider.trailingAnchor.constraint(equalTo: redSlider.trailingAnchor),
            blueSlider.topAnchor.constraint(equalTo: greenSlider.bottomAnchor, constant: 20),
            
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: blueSlider.bottomAnchor, constant: 30),
            
            stackView.leadingAnchor.constraint(equalTo: redSlider.leadingAnchor),
            
            stackView.trailingAnchor.constraint(equalTo: redSlider.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 20)
        ])
        
        // binding
        // ControlProperty, ControlEvent는 항상 메인스케줄러에서 실행됨
        
        // 슬라이더의 값을 바꾼결과를 레이블에 바인딩
        redSlider.rx.value
            .map { "\($0 / 255)"}
            .bind(to: redComponentLabel.rx.text)
            .disposed(by: bag)
        
        greenSlider.rx.value
            .map { "\($0 / 255)"}
            .bind(to: greenComponentLabel.rx.text)
            .disposed(by: bag)
        
        blueSlider.rx.value
            .map { "\($0 / 255)"}
            .bind(to: blueComponentLabel.rx.text)
            .disposed(by: bag)
        
        
        // 슬라이더의 밸류값을 감지하여 컬러뷰 색상변경
        let color = Observable.combineLatest([redSlider.rx.value, greenSlider.rx.value, blueSlider.rx.value])
        color
            .map { UIColor(red: CGFloat($0[0]), green: CGFloat($0[1]), blue: CGFloat($0[2]), alpha: 1.0) }
            .bind(to: colorView.rx.backgroundColor)
            .disposed(by: bag)
        
        // 초기화이벤트
        resetButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.colorView.backgroundColor = .black
                self?.redSlider.value = 0
                self?.greenSlider.value = 0
                self?.blueSlider.value = 0
                
                self?.redComponentLabel.text = "0"
                self?.greenComponentLabel.text = "0"
                self?.blueComponentLabel.text = "0"
            })
            .disposed(by: bag)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
