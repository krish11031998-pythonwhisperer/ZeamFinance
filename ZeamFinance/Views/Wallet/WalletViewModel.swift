//
//  WalletViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

class WalletViewModel {
	
	private var cards: [CardModel]?
	private var transactions: [TransactionModel]?
	public weak var view: AnyTableView?
	
	public func loadData() {
		cards = [.init(bankName: "Emirates NBD", name: "Krishna Venkatramani")]
		transactions = [.init(cellLogo: .IconCatalogue.amazon.image, detail: "amazon", amount: 250),
						.init(cellLogo: .IconCatalogue.netflix.image, detail: "netflix", amount: 50),
						.init(cellLogo: .IconCatalogue.zomato.image, detail: "zomato", amount: 80)]
		view?.reloadTableWithDataSource(buildDatasource())
	}
	
	private func circleChart(_ to: Float) -> UIView {
		GenericCircularProgressBar(frame: .init(origin: .zero, size: .init(squared: 22)),
								   radiusOffset: -1,
								   strokeColor: .parkGreen500,
								   strokeEnd: CGFloat(to),
								   animateStrokeEnd: false)
	}

	private var summarySection: TableSection {
		let percent = Float.random(in: 10..<40)
		let imgView = UIImageView(image: .IconCatalogue.coins.image)
		imgView.frame = .init(origin: .zero, size: .init(squared: 22))
		let cells: [AccountSummaryModel] = [.init(topView: circleChart(percent/40),
												  title: String(format: "%.2f", (percent/40.0) * 100) + " %",
												  subTitle: "Budget Spent"),
											.init(topView: imgView, title: "\(Int.random(in: 10..<100))", subTitle: "Z Coins")]
		let collectionCells = cells.compactMap { CollectionItem<AccountSummaryCollectionCell>($0) }
		return .init(rows: [TableRow<CollectionTableCell>(.init(cells: collectionCells, cellSize: .init(width: 125, height: 100)))],
					 title: "Spending Summary")
	}
	
	private var creditScoreView: TableSection {
		let creditScoreView = CreditScoreView()
		creditScoreView.configureView(.init(score: 750))
		let view = UIView()
		view.addSubview(creditScoreView)
		view.setFittingConstraints(childView: creditScoreView, top: 0, leading: 10, trailing: 10, bottom: 0, centerX: 0, priority: .needed)
		return .init(rows: [TableRow<CustomTableCell>(.init(view: view, inset: .zero))],
															title: "Credit Card Score")
	}
	
	private var cardCells: [TableCellProvider] {
		cards?.compactMap { TableRow<CardViewTableCell>(.init(card: $0)) } ?? []
	}
	
	private var txnCells: [TableCellProvider] {
		transactions?.compactMap { TableRow<TransactionCell>(.init(transaction: $0)) } ?? []
	}
	
	private var cardTransactionSection: TableSection {
		let moreCell = CustomButton()
		moreCell.configureButton(.init(title: "view more".bold(size: 13),
									   buttonType: .slender,
									   buttonStyling: .init(borderColor: .surfaceBackgroundInverse), action: {
			NotificationCenter.default.post(name: .showAllTransactions, object: nil)
		}))
		moreCell.setWidth(width: moreCell.compressedSize.width, priority: .required)
		
		let stack: UIStackView = .HStack(subViews: [moreCell, .spacer()],spacing: 0, alignment: .center)
		
		return .init(rows: cardCells + txnCells + [TableRow<CustomTableCell>(.init(view: stack, inset: .init(by: 10)))],
					 title: "Card")
	}
	
	func setupHeaderView() {
		let headerView = WalletHeaderView()
		let txns = Array(repeating: transactions?.randomElement(), count: Int.random(in: 2..<10)).compactMap {$0}
		let dailyModel: TransactionDailyModel = .init(txns: txns)
		let weekly: TransactionWeeklyModel = .init(daily: Array(repeating: dailyModel, count: 7))
		headerView.configureHeaderView(weekly)
		view?.setupHeaderView(view: headerView)
	}
	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [cardTransactionSection, creditScoreView, summarySection])
	}
	
}
