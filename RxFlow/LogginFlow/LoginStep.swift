//
//  LoginStep.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 22.05.2022.
//

import Foundation
import RxFlow

enum LoginStep: Step {
    case needToLogin
    case isLogedIn
}
