//
//  MainFlow.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 22.05.2022.
//

import Foundation
import RxFlow

class MainFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.navigationBar.topItem?.title = "Main"
        return viewController
    }()
    
    private let services: AppServices
    private let stepper: MainStepper

    init(withServices services: AppServices, stepper: MainStepper) {
        self.services = services
        self.stepper = stepper
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainStep else { return .none }

        switch step {
        case .onMainScreen:
            return self.navigateToMainScreen()
        default:
            return .none
        }
    }
    
    func navigateToMainScreen() -> FlowContributors {
        let mainViewController = MainViewController(viewModel: MainViewControllerVIewModel())
        DispatchQueue.main.async  {
            self.rootViewController.pushViewController(mainViewController, animated: false)
        }
        return .one(flowContributor: .contribute(withNextPresentable: mainViewController, withNextStepper: CompositeStepper(steppers: [mainViewController.viewModel, mainViewController]), allowStepWhenNotPresented: true))
    }
    
    
}
