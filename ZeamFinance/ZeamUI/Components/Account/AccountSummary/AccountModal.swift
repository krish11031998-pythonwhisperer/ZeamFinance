//
//  AccountModal.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 12/10/2022.
//

import Foundation
import UIKit

fileprivate extension TransactionModel {
	
	init(_ payment: PaymentCardModel) {
		self.init(cellLogo: payment.billCompanyLogo,
				  detail: payment.billDescription,
				  amount: payment.amount,
				  receiptModel: payment.receiptItems,
				  status: true)
	}
	
}

class AccountModal: UIViewController {
	
	private var accounts: [AccountModel]? { AccountStorage.accountsForUser }
	private lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.backgroundColor = .surfaceBackground
        table.showsVerticalScrollIndicator = false
		table.separatorStyle = .none
		return table
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
        setupNavbar()
		setupView()
	}
	
	private func setupView() {
		let rowCellHeight: CGFloat = 200
		let insets: CGFloat = UIWindow.key?.safeAreaInsets.bottom ?? 0 + 20
        
        view.backgroundColor = .surfaceBackground
        view.cornerRadius(16, corners: .top)
        view.clipsToBounds = true
        
		view.addSubview(tableView)
        view.setFittingConstraints(childView: tableView, insets: .init(top: navbarHeight, left: 0, bottom: view.safeAreaInsets.bottom, right: 0))
		tableView.reloadData(buildDatasource())
		
        let tableContentHeight = CGFloat(accounts?.count ?? 0) * rowCellHeight + insets
        
        tableView.isScrollEnabled = tableContentHeight > .totalHeight
        
		preferredContentSize = .init(width: .totalWidth, height: tableContentHeight)
	}
	
	private func setupNavbar() {
		mainPageNavBar(title: "Select Account", isTransparent: false, isModal: true)
		navigationController?.navigationBar.clippedCornerRadius = 16
		navigationController?.additionalSafeAreaInsets = .init(vertical: 10, horizontal: 0)
	}
	
	private var accountSection: TableSection? {
		guard let validAccounts = accounts, let payment = PaymentStorage.paymentToBePaid else { return nil }
		let cells = validAccounts.map { account in
			TableRow<AccountCardTableCell>(.init(account: account) {
				TransactionStorage.selectedTransaction = TransactionModel(payment)
				NotificationCenter.default.post(name: .showTxn, object: nil)
			})
		}
		return .init(rows: cells)
	}
	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [accountSection].compactMap { $0 })
	}
}
