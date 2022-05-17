//
//  ViewModelType.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 10.05.2022.
//

import Foundation

protocol ViewModelType: AnyObject {
    associatedtype Input
    associatedtype Output
    
    var input: Input! { get }
    var output: Output! { get }
}
