//
//  ContainerViewController.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 18.05.2022.
//

import UIKit

class ContainerViewController: UIViewController {
    
    let menuVC = MenuViewController()
    let profileVC = ProfileViewController()
    //let mainVC = MainViewController(viewModel: )

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func addChildViewControllers() {
        //Menu
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //Profile
        let navigationController = UINavigationController(rootViewController: profileVC)
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
        
    }



}
