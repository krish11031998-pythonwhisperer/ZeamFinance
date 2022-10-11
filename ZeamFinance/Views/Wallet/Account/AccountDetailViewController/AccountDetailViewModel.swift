//
//  AccountDetailViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 11/10/2022.
//

import Foundation
import UIKit

class AccountDetailViewModel {
	
	public var view: AnyTableView?
	private var model: AccountModel? { AccountStorage.selectedAccount }
	private var transactions: [TransactionModel]?
	
	func loadData() {
		transactions = [.init(cellLogo: .IconCatalogue.amazon.image, detail: "amazon", amount: 250),
						.init(cellLogo: .IconCatalogue.netflix.image, detail: "netflix", amount: 50),
						.init(cellLogo: .IconCatalogue.zomato.image, detail: "zomato", amount: 80)]
		accountHeader()
		view?.reloadTableWithDataSource(buildDatasource())
	}
	
	//MARK: - Views
	private func moreButton(title: RenderableText? = nil, titleString: String? = nil, action: Callback? = nil) -> TableCellProvider  {
		let moreCell = CustomButton()
		moreCell.configureButton(.init(title: titleString?.bold(size: 13) ?? title ?? "",
									   buttonType: .slender,
									   buttonStyling: .init(borderColor: .surfaceBackgroundInverse), action: {
			NotificationCenter.default.post(name: .showAllTransactions, object: nil)
		}))
		moreCell.setWidth(width: moreCell.compressedSize.width, priority: .required)
		
		let stack: UIStackView = .HStack(subViews: [moreCell, .spacer()],spacing: 0, alignment: .center)
		return TableRow<CustomTableCell>(.init(view: stack, inset: .init(by: 10)))
	}

	private func accountHeader(){
		guard let account = model else { return }
		let balanceLabel = DualLabel()
		balanceLabel.configureLabel(title: account.currency.bold(size: 30),
									subTitle: String(format: "\(account.isCrypto ? "$ " : "")%.2f", account.balance).bold(size: 40),
									config: .init(alignment: .center, spacing: 10))
		view?.setupHeaderView(view: balanceLabel.embedInView(insets: .init(vertical: 10, horizontal: 0)))
	}
	
	//MARK: - CellProviders
	private var txnCells: [TableCellProvider] {
		transactions?.compactMap { TableRow<TransactionCell>(.init(transaction: $0)) } ?? []
	}
	
	//MARK: - Section
	private var transactionSection: TableSection {
		.init(rows: txnCells + [moreButton(titleString: "view more")], title: "Transactions")
	}
	
	//MARK: - TableDatasource
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [transactionSection])
	}
}
