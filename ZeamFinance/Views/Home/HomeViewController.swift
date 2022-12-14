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
	private lazy var balanceAmount: UILabel = { .init() }()
	private lazy var balanceBarItem: UIBarButtonItem = {
		let view = UIView()
		view.addSubview(balanceAmount)
		view.setFittingConstraints(childView: balanceAmount, insets: .init(by: 7.5))
		view.backgroundColor = .surfaceBackgroundInverse
		view.clippedCornerRadius = 12
		return .init(customView: view)
	}()
	private var hide: Bool = true
	private var observer: NSKeyValueObservation?
	
	private lazy var viewModel: HomeViewModel = {
		let model = HomeViewModel()
		model.view = self
		return model
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		viewModel.loadData()
		String(format: "Balance: $%.2f", Float.random(in: 100..<1000)).medium(color: .textColorInverse, size: 11).render(target: balanceAmount)
		addObserver()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		guard let item = balanceBarItem.customView else { return }
		item.frame.origin.y = item.compressedSize.height.half
		item.layer.opacity = 0
		mainPageNavBar(title: "Zeam", rightBarButton: balanceBarItem)
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
		tableView.headerView = header
	}
	
	private func addObserver() {
		NotificationCenter.default.addObserver(self, selector: #selector(showAllTransactions), name: .showAllTransactions, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(showQRScanner), name: .payNow, object: nil)
		observer = tableView.observe(\.contentOffset) { [weak self] tableView, _ in self?.handleScrollOffsetChange(tableView) }
	}

	@objc
	func showAllTransactions() {
		navigationController?.pushViewController(WalletTransactionViewController(), animated: true)
	}
	
	@objc
	func showQRScanner() {
		let presentedController = QRCodeReaderViewController<PaymentQRCodeModel> { payment in
			guard let validPayment = payment else { return }
			PaymentStorage.selectedPayment = .init(billCompany: validPayment.billCompany,
												   billDescription: validPayment.billDescription,
												   amount: validPayment.amount,
												   billCompanyLogo: .init(), receiptItems: validPayment.receiptItems,
												   type: validPayment.type)
		}
		presentCard(controller: presentedController, withNavigation: true) {
			print("(DEBUG) read QR Code!")
			if PaymentStorage.selectedPayment != nil {
				self.presentCard(controller: PaymentModal(), withNavigation: false) {
					PaymentStorage.selectedPayment = nil
				}
			}
		}
	}
	
	private func handleScrollOffsetChange(_ scrollView: UIScrollView) {
		guard let view = balanceBarItem.customView else { return }
		let contentOff = scrollView.contentOffset
		if contentOff.y >= 0 && hide {
			hide.toggle()
            view.layer.animate(animation: .slideIn(from: view.frame.height, to: view.frame.height.half - 7.5, duration: 0.25))
		} else if !hide && contentOff.y < 0 {
			hide.toggle()
			view.layer.animate(animation: .slideIn(from: view.frame.height.half, to: view.frame.height, show: false, duration: 0.25))
		}
	}
}

//MARK: - AnyTable
extension HomeViewController: AnyTableView {
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource) {
		tableView.reloadData(dataSource)
	}
}
