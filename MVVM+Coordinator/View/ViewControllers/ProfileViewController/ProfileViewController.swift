//
//  ProfileViewController.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 18.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    init() {
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
