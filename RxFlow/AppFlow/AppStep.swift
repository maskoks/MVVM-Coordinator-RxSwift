//
//  AppStep.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 22.05.2022.
//

import Foundation
import RxFlow

enum AppStep: Step {
    case login
    case mainScreen
    case unknown
}
