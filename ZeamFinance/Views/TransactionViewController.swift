//
//  TransactionViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 06/10/2022.
//

import Foundation
import UIKit

class TransactionViewController: UIViewController {
	
	private lazy var tableView: UITableView =  {
		let table: UITableView = .init(frame: .zero, style: .grouped)
		table.separatorStyle = .none
		return table
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		standardNavBar()
	}
	
	private func setupView() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.backgroundColor = .surfaceBackground
		tableView.reloadData(buildDatasource())
	}
	
	private var transactionSection: TableSection {
		let txns: [TransactionModel] = [.init(cellLogo: .IconCatalogue.amazon.image, detail: "amazon", amount: 250),
										.init(cellLogo: .IconCatalogue.netflix.image, detail: "netflix", amount: 50),
										.init(cellLogo: .IconCatalogue.zomato.image, detail: "zomato", amount: 80)]
		return .init(rows: txns.compactMap { TableRow<TransactionCell>($0) }, title: "Transactions")
	}
	
	private var cardSection: TableSection {
		let cardView = CardView(frame: .init(origin: .zero, size: .init(width: .totalWidth, height: .totalWidth/1.75)))
		cardView.configureCard(.init(bankName: "Emirates NBD", name: "Krishna Venkatramani"))
		return .init(rows: [TableRow<CustomTableCell>(.init(view: cardView, inset: .init(vertical: 0, horizontal: 8)))], title: "Cards")
	}
	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [cardSection ,transactionSection])
	}
	
}
