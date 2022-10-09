//
//  PaymentViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 09/10/2022.
//

import Foundation
import UIKit

class PayViewController: UIViewController {
	
	//MARK: - Properties
	private lazy var viewModel: PaymentViewModel = {
		let model = PaymentViewModel()
		model.view = self
		return model
	}()
	
	private lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.backgroundColor = .surfaceBackground
		table.separatorStyle = .none
		return table
	}()
	
	//MARK: - Overriden Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		mainPageNavBar(title: "Pay")
		viewModel.loadData()
		setupView()
		addObservers()
	}
	
	//MARK: - Protected Methods
	private func setupView() {
		view.backgroundColor = .surfaceBackground
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
	}
	
	private func addObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(readQRCode), name: .readQRCode, object: nil)
	}
	
	@objc
	private func readQRCode() {
		presentCard(controller: QRCodeReaderViewController(), withNavigation: true) {
			print("(DEBUG) read QR Code!")
			if PaymentStorage.selectedPayment != nil {
				self.presentCard(controller: PaymentModal(), withNavigation: false) {
					PaymentStorage.selectedPayment = nil
				}
			}
		}
	}
	
}


extension PayViewController: AnyTableView {
	
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource) {
		tableView.reloadData(dataSource)
	}
	
}
