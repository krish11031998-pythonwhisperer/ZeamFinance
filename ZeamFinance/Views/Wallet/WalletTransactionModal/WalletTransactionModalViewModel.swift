//
//  WalletTransactionModalViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 09/10/2022.
//

import Foundation
import UIKit

extension PaymentReceiptModel {
	
	func receiptView(includeButton: Bool = true ) -> UIView {
		let description = description.medium(size: 15).generateLabel
		let amount = String(format: "%.2f", units * unitPrice).regular(size: 13).generateLabel
		let stack: UIStackView = .HStack(spacing: 12)
		[description, .spacer(), amount].forEach(stack.addArrangedSubview)
		if includeButton {
			let plusImage = UIImageView(image: .init(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))?.resized(size: .init(squared: 12)))
			plusImage.contentMode = .center
			plusImage.backgroundColor = .surfaceBackgroundInverse
			plusImage.clipsToBounds = true
			plusImage.circleFrame = .init(origin: .zero, size: .init(squared: 24))
			stack.addArrangedSubview(plusImage)
			stack.setFittingConstraints(childView: plusImage, width:24, height:24, priority: .needed)
		}
//		plusImage.isHidden = !includeButton
		return stack
	}
	
	func cell(_ action: Callback? = nil) -> TableCellProvider {
		return TableRow<CustomTableCell>(.init(view: receiptView(), inset: .init(by: 10), action: action))
	}
}

extension TransactionModel {
	
	var txnDetails: [String: String] {
		["Date": date,
		 "Detail": detail,
		 "Status": isCompleted ? "Completed" : "Unpaid"]
	}
	
	var statusStyled: RenderableText {
		let labelTxt = isCompleted ? "Completed" : "Unpaid"
		return labelTxt.bold(color: isCompleted ? .success500 : .warning500, size: 12)
	}
	
	var txnDetail: [TableCellProvider] {
		let cell: [TableCellProvider] = txnDetails.sorted(by: { $0.key < $1.key }).map { (key,value) in
			let rowStack = UIStackView.HStack(spacing: 12)
			let stack: UIStackView = .VStack(spacing: 10)
			let keyLabel = key.regular(size: 12).generateLabel
			let valueLabel = (key == "Status" ?  statusStyled : value.capitalized.regular(size: 12)).generateLabel
			[keyLabel,.spacer(),valueLabel].forEach(rowStack.addArrangedSubview(_:))
			let divider = UIView()
			divider.backgroundColor = .surfaceBackgroundInverse
			[rowStack,divider].forEach(stack.addArrangedSubview(_:))
			stack.setFittingConstraints(childView: divider, leading: 0, trailing: 0, height: 0.5)
			return TableRow<CustomTableCell>(.init(view: stack, inset: .init(vertical: 5, horizontal: 10)))
		}
		return cell
	}
}

class WalletTransactionModalViewModel {
	
	private var transaction: TransactionModel? { TransactionStorage.selectedTransaction }
	private var receiptItems: Set<PaymentReceiptModel>?
	public weak var view: AnyTableView?
	
	public var tableHeader: UIView? {
		guard let validTransaction = transaction else { return nil }
		let stackView = UIStackView.HStack(spacing: 12)
		let txnInfoLabel = DualLabel()
		txnInfoLabel.configureLabel(title: validTransaction.detail.capitalized.sectionHeader(size: 15),
									subTitle: String(format: "$ %.2f", validTransaction.amount).bold(size: 35))
		let imageView = validTransaction.cellLogo.imageView(size: .init(squared: 64))
		imageView.setFrame(.init(squared: 64))
		imageView.contentMode = .scaleAspectFit
		imageView.backgroundColor = .popWhite500
		imageView.border(color: .surfaceBackgroundInverse, borderWidth: 1, cornerRadius: 8)
		[txnInfoLabel, .spacer(), imageView].forEach(stackView.addArrangedSubview(_:))
		let headerView = stackView.embedInView(insets: .init(by: 15), priority: .needed)
		return headerView
	}
	
	public func loadView() {
		view?.reloadTableWithDataSource(buildDatasource())
	}
	
	//MARK: - Protected Methods
	
	private var pointsScores: TableSection? {
		guard let selectedPointScored = transaction?.amount else { return nil }
		let stack = UIStackView.HStack(spacing: 8)
		let imgView = UIImageView(image: .IconCatalogue.coins.image)
		let label = String(format: "%.2f", selectedPointScored).bold(color: .textColorInverse, size: 30).generateLabel
		[imgView, label, .spacer()].forEach(stack.addArrangedSubview(_:))
		stack.setFittingConstraints(childView: imgView, width: 48, height: 48, priority: .needed)
		let header = "ZFI earned from this transaction".medium(color: .textColorInverse, size: 13).generateLabel
		let mainStack = UIStackView.VStack(subViews: [header.embedInView(insets: .init(by: 5)), stack], spacing: 5, alignment: .leading)
		let view = mainStack.background()
		return .init(rows: [TableRow<CustomTableCell>(.init(view: view, inset: .init(vertical: 5, horizontal: 10))), generateMoreCoin].compactMap { $0 },
					 title: "Zeam Coins Earned")
	}
	
	private var txnDetails: TableSection? {
		guard let validTransaction = transaction else { return nil}
		return .init(rows: validTransaction.txnDetail, title: "Transaction Detail")
	}
	
	private var productReceipt: TableSection? {
		guard let validTransaction = transaction, !validTransaction.receiptModel.isEmpty else { return nil }
		let cells = validTransaction.receiptModel.map {item in item.cell { self.addValue(item) }}
		return .init(rows: cells, title: "Receipt")
	}
	
	private var generateMoreCoin: TableCellProvider? {
		guard let validReceipt = receiptItems, !validReceipt.isEmpty else { return nil }
		let header = "ZFI you can earn from selling your data".medium(color: .textColor, size: 13).generateLabel
		let button = CustomButton()
		button.configureButton(.init(title: "Sell Your Data".regular(size: 12),
									 backgroundColor: .surfaceBackground,
									 buttonType: .slender,
									 action: sellData))
		let stack: UIStackView = .VStack(subViews: [header] + validReceipt.compactMap { $0.receiptView(includeButton: false) } + [button],
										 spacing: 15)
		let view = stack.embedInView(insets: .init(by: 12), priority: .needed)
		view.backgroundColor = .info400
		view.clippedCornerRadius = 12
		return TableRow<CustomTableCell>(.init(view: view, inset: .init(by: 12)))
	}
	
	private var txnSection: TableSection? {
		guard let selectedTxn = transaction else { return nil }
		return .init(rows: Array(repeating: TableRow<TransactionCell>(.init(transaction: selectedTxn)), count: 1))
	}
	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [txnDetails, productReceipt, pointsScores].compactMap { $0 })
	}
	
	private func addValue(_ receiptItem: PaymentReceiptModel) {
		if receiptItems == nil {
			receiptItems = [receiptItem]
		} else {
			receiptItems?.insert(receiptItem)
		}
		view?.reloadTableWithDataSource(buildDatasource())
	}
	
	
	private func sellData() {
		print("(DEBUG) sell Button was clicked!")
	}
}
