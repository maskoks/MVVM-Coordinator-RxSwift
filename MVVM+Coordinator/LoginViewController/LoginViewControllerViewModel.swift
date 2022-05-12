//
//  LoginViewControllerViewModel.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 10.05.2022.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewControllerViewModel: ViewModelType {

    struct Input {
        let reload: AnyObserver<Void>
        let loginTextFieldText: AnyObserver<String>
        let passwordTextFieldText: AnyObserver<String>
        let buttonPressed: AnyObserver<Void>
    }
    
    struct Output {
        let logIn: Driver<Bool>
        let buttonEnabled: Driver<Bool>
    }
    
    public let reloadPublish = PublishSubject<Void>()
    public let loginTextFieldTextPublish = ReplaySubject<String>.create(bufferSize: 1)
    public let passwordTextFieldTextPublish = ReplaySubject<String>.create(bufferSize: 1)
    public let buttonPressedPublish = PublishSubject<Void>()
    
    internal var input: Input!
    internal var output: Output!
    
    private let login = "admin"
    private let password = "1234"

    init() {
        self.input = Input(
            reload: reloadPublish.asObserver(),
            loginTextFieldText: loginTextFieldTextPublish.asObserver(),
            passwordTextFieldText: passwordTextFieldTextPublish.asObserver(),
            buttonPressed: buttonPressedPublish.asObserver()
        )
        self.output = Output(
            logIn: self.logInBusinessLogic(correcrLogin: self.login, correctPassword: self.password),
            buttonEnabled: self.buttonEnabled()
            )
    }
    
    private func buttonEnabled() -> Driver<Bool> {
        return Observable
            .merge(
                self.reloadPublish
                    .flatMapLatest({ _ in
                        return Observable.just(false)
                    }),
                Observable
                    .combineLatest(self.loginTextFieldTextPublish, self.passwordTextFieldTextPublish) { login, password in
                        return login.count > 0 && password.count > 0
                    }
            )
        .asDriver(onErrorJustReturn: false)
    }
    
    private func logInBusinessLogic(correcrLogin: String, correctPassword: String) -> Driver<Bool> {
        return self.buttonPressedPublish
            .withLatestFrom(self.loginTextFieldTextPublish)
            .withLatestFrom(self.passwordTextFieldTextPublish) { login, password in
                return login == correcrLogin && password == correctPassword
            }
            .asDriver(onErrorJustReturn: true)
    }
}


