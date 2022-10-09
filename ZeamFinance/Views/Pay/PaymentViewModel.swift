//
//  PaymentViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 09/10/2022.
//

import Foundation

class PaymentViewModel {
	
	//MARK: - Properties
	public var view:AnyTableView?
	private var bills: [PaymentCardModel]?
	
	//MARK: - Exposed
	public func loadData() {
		fetchBills()
		view?.reloadTableWithDataSource(buildDataSource())
	}
	
	//MARK: - Protected Methods
	private func fetchBills() {
		bills = [.dewa, .person, .installment]
	}
	
	private var billSection: TableSection? {
		guard let validBills = bills else { return nil }
		let cells = validBills.compactMap { CollectionItem<PaymentCardCollectionCell>($0)}
		return .init(rows: [TableRow<CollectionTableCell>(.init(cells: cells,
																cellSize: .init(width: 225, height: 300)))], title: "Upcoming Bills")
	}
	
	private var paySection: TableSection? {
		.init(rows: [TableRow<CardViewTableCell>(.init(card: .init(bankName: "Emirated NBD", name: "John Doe"), action: {
			NotificationCenter.default.post(name: .readQRCode, object: nil)
		}))], title: "Pay Now!")
	}
	
	private func buildDataSource() -> TableViewDataSource {
		.init(sections:  [paySection, billSection].compactMap { $0 })
	}
	
}
