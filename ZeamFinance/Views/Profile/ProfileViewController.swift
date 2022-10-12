//
//  ProfileViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 12/10/2022.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {

	private lazy var viewModel: ProfileViewModel = {
		let model = ProfileViewModel()
		model.view = self
		return model
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .grouped)
		tableView.backgroundColor = .surfaceBackground
		tableView.separatorStyle = .none
		return tableView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupNavbar()
		viewModel.loadData()
	}
	
	private func setupView() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
	}
	
	private func setupNavbar() {
		mainPageNavBar(title: "Profile", isTransparent: false)
	}
}


extension ProfileViewController: AnyTableView {
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource) {
		tableView.reloadData(dataSource)
	}
}
