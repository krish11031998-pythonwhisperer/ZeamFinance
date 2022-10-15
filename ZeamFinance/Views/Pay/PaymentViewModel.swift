//
//  PaymentViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 09/10/2022.
//

import Foundation
import UIKit

fileprivate extension Array where Element == PaymentCardModel {
	
	func computeRatio() -> [Self.Element : Float] {
		var ratios: [Self.Element : Float] = [:]
		forEach {
			if let val = ratios[$0] {
				ratios[$0] = val + $0.amount
			} else {
				ratios[$0] = $0.amount
			}
		}
		return ratios
	}
}

fileprivate extension Dictionary where Key == PaymentCardModel, Value == Float {
	
	var views: [UIView] {
		var views: [UIView] = []
		forEach {
			let infoLabel = DualLabel()
			infoLabel.configureLabel(title: $0.key.type.rawValue.capitalized.bold(size: 12),
									 subTitle: String(format: "%.2f",$0.value).medium(size: 20), config: .init(spacing: 5))
			let blob = UIView()
			blob.backgroundColor = $0.key.type.color
			blob.setFrame(.init(squared: 32))
			blob.circleFrame = .init(origin: .zero, size: .init(squared: 32))
			
			views.append(.HStack(subViews: [infoLabel, .spacer(), blob], spacing: 10, alignment: .center))
		}
		return views
	}
}

class PaymentViewModel {
	
	//MARK: - Properties
	public weak var view:AnyTableView?
	private var bills: [PaymentCardModel]?
	
	//MARK: - Exposed Methods
	public func loadData() {
		fetchBills()
		view?.reloadTableWithDataSource(buildDataSource())
	}
	
	//MARK: - Protected Methods
	private func fetchBills() {
		bills = [.dewa, .person, .installment]
	}
	
	//MARK: - TableCellProvider
	private var billSummary: TableCellProvider? {
		guard let validBills = bills else { return nil }
		let header = "Summary of bills".bold(size: 20).generateLabel
		let total = DualLabel()
		total.configureLabel(title: "Total".bold(size: 12),
							 subTitle: String(format: "%.2f",  validBills.compactMap { $0.amount }.reduce(0, +)).medium(size: 25))
		
		let view = UIStackView.VStack(spacing: 10)
		([header, total] + validBills.computeRatio().views).addToView(view)
		let coloredView = view.embedInView(insets: .init(by: 10))
		coloredView.backgroundColor = .clear
		coloredView.border(color: .surfaceBackgroundInverse, borderWidth: 1, cornerRadius: 12)
		
		return TableRow<CustomTableCell>(.init(view: coloredView, inset: .init(by: 10)))
	}
	
	private var billCollection: TableCellProvider? {
		guard let validBills = bills else { return nil }
		let cells = validBills.compactMap { CollectionItem<PaymentCardCollectionCell>($0)}
		return TableRow<CollectionTableCell>(.init(cells: cells, cellSize: .init(squared: 225)))
	}
	
	//MARK: - TableSections
	
	private var billSection: TableSection? {
		return .init(rows: [billSummary, billCollection].compactMap { $0 }, title: "Upcoming Bills")
	}
	
	private var paySection: TableSection? {
		.init(rows: [TableRow<CardViewTableCell>(.init(card: .init(bankName: "Emirated NBD", name: "John Doe"), action: {
			NotificationCenter.default.post(name: .readQRCode, object: nil)
		}))], title: "Pay Now!")
	}
	
	//MARK: - TableDataSource
	private func buildDataSource() -> TableViewDataSource {
		.init(sections:  [paySection, billSection].compactMap { $0 })
	}
	
}
