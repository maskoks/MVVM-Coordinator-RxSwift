//
//  LoginViewController.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 09.05.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow

class LoginViewController: UIViewController, Stepper {

    // MARK: - IBOutlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    let viewModel: LoginViewControllerViewModel
    
    // MARK: - Private Properties
    private let disposeBag = DisposeBag()
    internal var steps = PublishRelay<Step>()
    
    // MARK: - Life cycle
    init(viewModel: LoginViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.layer.cornerRadius = 7
        self.loginTextField.addDoneButtonOnKeyboard()
        self.passwordTextField.addDoneButtonOnKeyboard()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        bindViewModelInputs()
        bindViewModelOutPuts()
    }
    
    
    // MARK: - RX
    private func bindViewModelInputs() {
        self.loginTextField
            .rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                guard let `self` = self else { return }
                self.viewModel.input.loginTextFieldText.onNext(text)
            })
            .disposed(by: self.disposeBag)
        self.passwordTextField
            .rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                guard let `self` = self else { return }
                self.viewModel.input.passwordTextFieldText.onNext(text)
            })
            .disposed(by: self.disposeBag)
        self.loginButton
            .rx
            .tap
            .bind { [weak self] event in
                guard let `self` = self else { return }
                self.viewModel.input.buttonPressed.onNext(event)
                self.view.endEditing(true)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindViewModelOutPuts() {
        viewModel
            .output
            .buttonEnabled
            .drive(onNext:  { [weak self] isEnabled in
                guard let `self` = self else { return }
                self.loginButton.isEnabled = isEnabled
                self.loginButton.alpha = isEnabled ? 1.0 : 0.5
            }).disposed(by: disposeBag)
        viewModel
            .output
            .logIn
            .drive(onNext:  { [weak self] correctData in
                guard let `self` = self else { return }
                self.setUpStatus(with: correctData)
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Private Methods
    private func setUpStatus(with correctData: Bool) {
        if correctData {
            self.statusLabel.text = "OK"
            self.statusLabel.textColor = .green
        } else {
            self.statusLabel.text = "NOT OK"
            self.statusLabel.textColor = .red
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
