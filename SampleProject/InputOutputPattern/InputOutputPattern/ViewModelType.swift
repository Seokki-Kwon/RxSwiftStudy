//
//  ViewModelType.swift
//  InputOutputPattern
//
//  Created by 석기권 on 6/15/24.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Dependency
    associatedtype Input
    associatedtype Output
    
    var dependency: Dependency { get }
    var disposeBag: DisposeBag { get set }
    
    var input: Input { get }
    var ouput: Output { get }
    
    init(dependency: Dependency)
}
