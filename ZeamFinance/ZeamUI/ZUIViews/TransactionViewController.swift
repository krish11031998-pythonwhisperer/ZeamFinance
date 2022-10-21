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
		standardNavBar(title: "Transaction")
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
		return .init(rows: txns.compactMap { TableRow<TransactionCell>(.init(transaction: $0)) }, title: "Transactions")
	}
	
	private var cardSection: TableSection {
		let cardView = CardView(frame: .init(origin: .zero, size: .init(width: .totalWidth, height: .totalWidth/1.75)))
		cardView.configureCard(.init(bankName: "Emirates NBD", name: "Krishna Venkatramani"))
		return .init(rows: [TableRow<CustomTableCell>(.init(view: cardView, inset: .init(vertical: 0, horizontal: 8)))], title: "Cards")
	}
	
	private var paymentQRCode: TableSection? {
        let model = PaymentQRCodeModel(paymentModel: PaymentCardModel.person)
		guard let img = UIImage.generateQRCode(model) else { return nil }
		let imgView = UIImageView(image: img)
		let view = UIView()
		view.addSubview(imgView)
		view.setFittingConstraints(childView: imgView, top: 0, bottom: 0, width: 100, height: 100, centerX: 0, centerY: 0, priority: .needed)
		return .init(rows: [TableRow<CustomTableCell>(.init(view: view, inset: .zero))], title: "Transaction QR Code")
	}
	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [cardSection ,transactionSection] + [paymentQRCode].compactMap { $0 })
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		guard let img = navigationItem.leftBarButtonItem?.image else { return }
		navigationItem.leftBarButtonItem?.image = img.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal)
	}
}
