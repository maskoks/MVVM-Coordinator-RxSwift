//
//  MainStepper.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 23.05.2022.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class MainStepper: Stepper {
    let steps = PublishRelay<Step>()

    var initialStep: Step {
        return MainStep.onMainScreen
    }
}
