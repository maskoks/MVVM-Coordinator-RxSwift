//
//  LoginStepper.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 23.05.2022.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class LoginStepper: Stepper {
    let steps = PublishRelay<Step>()

    var initialStep: Step {
        return LoginStep.needToLogin
    }
}
