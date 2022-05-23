//
//  MainViewControllerVIewModel.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 17.05.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

class MainViewControllerVIewModel: ViewModelType, Stepper {
    internal var steps = PublishRelay<Step>()
    
    struct Input {
        let reload: AnyObserver<Void>
        let itemSelected: AnyObserver<IndexPath>
        let menu: AnyObserver<Void>
    }
    
    struct Output {
        let dataSource: Driver<[SectionModel<String, MainScreenDataSourceModel>]>
        let dataSourceCount: Driver<Int>
        let handleItemSelected: Driver<String>
    }
    
    internal var input: Input!
    internal var output: Output!

    private let reloadPublish = PublishSubject<Void>()
    private let itemSelectedPublish = PublishSubject<IndexPath>()
    private let menuPublish = PublishSubject<Void>()
    
    private let dataSource: [MainScreenDataSourceModel] = [
        MainScreenDataSourceModel(name: "😅", description: "SomeViewController1"),
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
            dataSource: self.getDataSource(dataSource: self.dataSource),
            dataSourceCount: Observable.just(self.dataSource.count).asDriver(onErrorJustReturn: 0),
            handleItemSelected: self.selectItem(dataSource: self.dataSource)
            )
    }
    
    private func getDataSource(dataSource: [MainScreenDataSourceModel]) -> Driver<[SectionModel<String, MainScreenDataSourceModel>]> {
        return self.reloadPublish
            .flatMapLatest { _ -> Observable<[SectionModel<String, MainScreenDataSourceModel>]> in
                let section = SectionModel(model: "", items: dataSource)
                let sections: [SectionModel<String, MainScreenDataSourceModel>] = [section]
                return Observable.just(sections)
            }
            .asDriver(onErrorJustReturn: [])
    }
    
    private func selectItem(dataSource: [MainScreenDataSourceModel]) -> Driver<String> {
        self.itemSelectedPublish
            .flatMapLatest { indexPath -> Observable<String> in
                let string = dataSource[indexPath.row].description
                return Observable.just(string)
            }
            .asDriver(onErrorJustReturn: "")
    }
}
