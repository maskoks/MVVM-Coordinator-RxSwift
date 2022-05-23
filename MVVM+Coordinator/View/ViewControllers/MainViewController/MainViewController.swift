//
//  MainViewController.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 17.05.2022.
//

import UIKit
import RxSwift
import RxDataSources
import RxFlow
import RxCocoa

class MainViewController: UIViewController, Stepper {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var menuButton: UIButton!
    
    // MARK: - Private Properties
    let viewModel: MainViewControllerVIewModel
    private let disposeBag = DisposeBag()
    internal var steps = PublishRelay<Step>()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource <SectionModel<String, MainScreenDataSourceModel>>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: String(describing: MainViewControllerCellTableViewCell.self)) as! MainViewControllerCellTableViewCell
            cell.titleLabel.text = element.name
            cell.descriptionLabel.text = element.description
            cell.accessoryType = .disclosureIndicator
            return cell
        })
    
    // MARK: - Life cycle
    init(viewModel: MainViewControllerVIewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.tableView.register(UINib(nibName: String(describing: MainViewControllerCellTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MainViewControllerCellTableViewCell.self))
        self.setUpView()
        self.bindViewModelInputs()
        self.bindViewModelOutputs()
        self.viewModel.input.reload.onNext(())
    }
    
    
    // MARK: - RX
    private func bindViewModelInputs() {
        self.tableView
            .rx
            .itemSelected
            .bind(to: self.viewModel.input.itemSelected)
            .disposed(by: self.disposeBag)
        self.menuButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                print("buttonTapped")
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindViewModelOutputs() {
        self.viewModel
            .output
            .dataSource
            .drive(tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
        self.viewModel
            .output
            .dataSourceCount
            .drive(onNext: { [weak self] dataSourceCount in
                guard let `self` = self else { return }
                self.tableViewHeight.constant = Constants.mainViewControllerCellHeight*CGFloat(dataSourceCount)
            })
            .disposed(by: self.disposeBag)
        self.viewModel
            .output
            .handleItemSelected
            .drive(onNext: { [weak self] string in
                guard let `self` = self else { return }
                print("output is \(string)")
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private Methods
    
    private func setUpView() {
        self.tableView.layer.cornerRadius = 10
        self.tableView.layer.borderWidth = 1
        self.tableView.layer.borderColor = UIColor.systemGray.cgColor
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.mainViewControllerCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
