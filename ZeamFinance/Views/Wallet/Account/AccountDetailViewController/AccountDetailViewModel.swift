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
	
	private var payButton: CustomButton {
		let button = CustomButton()
		let img = UIImage(systemName: "plus.circle")?.resized(size: .init(squared: 12))
		button.configureButton(.init(title: "Pay".regular(color: .textColorInverse,size: 12),
									 trailingImg: .init(img: img, size: .init(squared: 12)),
									 backgroundColor: .surfaceBackgroundInverse,
									 buttonType: .slender,
									 action: nil))
		return button
	}
	
	private var depositButton: CustomButton {
		let button = CustomButton()
		let img = UIImage(systemName: "plus")?.resized(size: .init(squared: 12))
		button.configureButton(.init(title: "Deposit".regular(color: .textColorInverse,size: 12),
									 trailingImg: .init(img: img, size: .init(squared: 12)),
									 backgroundColor: .surfaceBackgroundInverse,
									 buttonType: .slender,
									 action: nil))
		return button
	}

	private func accountHeader(){
		guard let account = model else { return }
		let stack: UIStackView = .VStack(spacing: 30, alignment: .center)
		let balanceLabel = DualLabel()
		balanceLabel.configureLabel(title: account.isCrypto ? account.currency.bold(size: 18) : "",
									subTitle: String(format: "\(account.isCrypto ? "$ " : "\(account.currency) ")%.2f", account.balance).bold(size: 40),
									config: .init(alignment: .center, spacing: 5))
		let buttonStack: UIStackView = .HStack(subViews:[payButton, depositButton], spacing: 10)
		buttonStack.distribution = .fillEqually

		[balanceLabel, "Balance".medium(color: .popBlack100, size: 13).generateLabel, buttonStack].forEach(stack.addArrangedSubview(_:))
		stack.setCustomSpacing(8, after: balanceLabel)
		stack.setFrame(width: .totalWidth, height: stack.compressedSize.height)
		view?.setupHeaderView(view: stack)
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
