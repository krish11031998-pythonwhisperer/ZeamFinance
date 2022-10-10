//
//  HomeViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 07/10/2022.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
	
	private lazy var tableView: UITableView = {
		let tableView: UITableView = .init(frame: .zero, style: .grouped)
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		return tableView
	}()
	
	private lazy var viewModel: HomeViewModel = {
		let model = HomeViewModel()
		model.view = self
		return model
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupHeader()
		viewModel.loadData()
		setupTransparentNavBar()
		addObserver()
	}
	
	private func setupView() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.backgroundColor = .surfaceBackground
	}
	
	private func setupHeader() {
		let header = HomeHeaderView()
		header.configureHeader()
		header.setFrame(width: .totalWidth, height: header.compressedSize.height)
		tableView.tableHeaderView = header
		tableView.tableHeaderView?.frame = .init(origin: .zero, size: .init(width: .totalWidth, height: header.compressedSize.height))
	}
	
	private func addObserver() {
		NotificationCenter.default.addObserver(self, selector: #selector(showPaymentModal), name: .showPayment, object: nil)
	}
	
	@objc
	func showPaymentModal() {
		presentCard(controller: PaymentModal(), withNavigation: false) {
			PaymentStorage.selectedPayment = nil
		}
	}
}


extension HomeViewController: AnyTableView {
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource) {
		tableView.reloadData(dataSource)
	}
}
