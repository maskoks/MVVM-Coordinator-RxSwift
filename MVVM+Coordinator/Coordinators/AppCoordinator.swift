//
//  AppCoordinator.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 17.05.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var isLoggenIn: Bool = false
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        if isLoggenIn {
            //showMain()
        } else {
            showLogin()
        }
    }
    
    func showLogin() {
        let viewModel = LoginViewControllerViewModel()
        let loginViewController = LoginViewController(viewModel: viewModel)
        navigationController.pushViewController(loginViewController, animated: true)
    }
}
