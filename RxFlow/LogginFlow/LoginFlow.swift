//
//  LoginFlow.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 22.05.2022.
//

import Foundation
import RxFlow

class LoginFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.navigationBar.topItem?.title = "LogIn"
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }()
    
    private let services: AppServices
    private let stepper: LoginStepper

    init(withServices services: AppServices, stepper: LoginStepper) {
        self.services = services
        self.stepper = stepper
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? LoginStep else { return .none }
        
        switch step {
        case .needToLogin:
            return self.navigateToLoginViewController()
        default:
            return .end(forwardToParentFlowWithStep: AppStep.mainScreen)
        }
    }
    
    func navigateToLoginViewController() -> FlowContributors {
        let loginVC = LoginViewController(viewModel: LoginViewControllerViewModel())
        self.rootViewController.pushViewController(loginVC, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: loginVC, withNextStepper: CompositeStepper(steppers: [loginVC.viewModel, loginVC]), allowStepWhenNotPresented: false))
    }
}
