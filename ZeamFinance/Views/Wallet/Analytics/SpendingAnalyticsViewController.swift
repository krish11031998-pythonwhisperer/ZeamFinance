//
//  SpendingAnalyticsViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 16/10/2022.
//

import Foundation
import UIKit

class SpendingAnalyticsViewController: UIViewController {
	
	private lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.separatorStyle = .none
		table.backgroundColor = .surfaceBackground
		return table
	}()
	
	private lazy var viewModel: SpendingAnalyticsViewModel = {
		let model = SpendingAnalyticsViewModel()
		model.view = self
		return model
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		viewModel.loadData()
        standardNavBar(title: "Spending Analytics", isTransparent: false)
	}
	
	private func setupView() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
	}
}

//MARK: - SpendingAnalyticsViewController AnyTableView

extension SpendingAnalyticsViewController: AnyTableView {
	
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource) {
		tableView.reloadData(dataSource)
	}
    
    func setupHeaderView(view: UIView) {
        tableView.tableHeaderView = view
        tableView.tableHeaderView?.frame = .init(origin: .zero, size: view.compressedSize)
    }
	
}

//MARK: - SpendingAnalytics Event Handler

extension SpendingAnalyticsViewController {
	
	private func addBindings() {
		viewModel.addBinding(.spending, action: showSpending)
	}
	
	private func showSpending() {
		print("(DEBUG) Clicked on Spending")
	}
	
}
