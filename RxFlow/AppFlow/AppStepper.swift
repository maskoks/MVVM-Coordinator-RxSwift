//
//  AppStepper.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 22.05.2022.
//

import Foundation
import RxSwift
import RxFlow
import RxCocoa

class AppStepper: Stepper {

    let steps = PublishRelay<Step>()
    private let appServices: AppServices
    private let disposeBag = DisposeBag()

    init(withServices services: AppServices) {
        self.appServices = services
    }

    var initialStep: Step {
        return AppStep.unknown
    }

    func readyToEmitSteps() {
        self.appServices
            .preferencesService.rx
            .isLogedIn
            .map { isLoggedIn in
                return isLoggedIn ? AppStep.mainScreen : AppStep.login
            }
            .bind(to: self.steps)
            .disposed(by: self.disposeBag)
    }
}
