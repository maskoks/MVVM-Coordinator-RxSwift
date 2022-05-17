//
//  MainViewControllerVIewModel.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 17.05.2022.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewControllerVIewModel: ViewModelType {
    struct Input {
        let reload: AnyObserver<Void>
        let itemSelected: AnyObserver<IndexPath>
        let menu: AnyObserver<Void>
    }
    
    struct Output {
        let dataSource: Driver<[MainScreenDataSourceModel]>
    }
    
    internal var input: Input!
    internal var output: Output!

    private let reloadPublish = PublishSubject<Void>()
    private let itemSelectedPublish = PublishSubject<IndexPath>()
    private let menuPublish = PublishSubject<Void>()
    
    private let dataSource: [MainScreenDataSourceModel] = [
        MainScreenDataSourceModel(name: "🫥", description: "SomeViewController1"),
        MainScreenDataSourceModel(name: "🎃", description: "SomeViewController2"),
        MainScreenDataSourceModel(name: "😺", description: "SomeViewController3"),
        MainScreenDataSourceModel(name: "🤠", description: "SomeViewController4")
    ]

    init() {
        self.input = Input(
            reload: self.reloadPublish.asObserver(),
            itemSelected: self.itemSelectedPublish.asObserver(),
            menu: menuPublish.asObserver()
        )
        self.output = Output(
            dataSource: Observable.just(self.dataSource).asDriver(onErrorJustReturn: [])
            )
    }
}
