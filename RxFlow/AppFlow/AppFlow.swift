//
//  AppFlow.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 22.05.2022.
//

import Foundation
import RxFlow
import RxCocoa
import RxSwift

class AppFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        switch step {
        case .login:
            return self.navigateToLoginScreen()
        case .mainScreen:
            return self.navigateToMainScreen()
        default:
            return .none
        }
    }
    
    func navigateToLoginScreen() -> FlowContributors {
        let stepper = LoginStepper()
        let loginFlow = LoginFlow(withServices: self.services, stepper: stepper)
        Flows.use(loginFlow, when: .created) { [unowned self] root in
            DispatchQueue.main.async  {
                self.rootViewController.present(root, animated: false)
            }
        }
        return .one(flowContributor: .contribute(withNextPresentable: loginFlow, withNextStepper: stepper))
    }
    
    func navigateToMainScreen() -> FlowContributors {
        let stepper = MainStepper()
        let mainFlow = MainFlow(withServices: self.services, stepper: stepper)
        Flows.use(mainFlow, when: .created) { [unowned self] root in
            DispatchQueue.main.async  {
                self.rootViewController.present(root, animated: false)
            }
        }
        return .one(flowContributor: .contribute(withNextPresentable: mainFlow, withNextStepper: stepper))
    }
}


