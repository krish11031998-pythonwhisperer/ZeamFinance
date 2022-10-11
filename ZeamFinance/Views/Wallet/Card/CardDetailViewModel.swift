//
//  CardDetailViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 11/10/2022.
//

import Foundation
import UIKit

class CardDetailViewModel {
	
	public var view: AnyTableView?
	private var transactions: [TransactionModel]?
	
	
	init() {
		transactions = [.init(cellLogo: .IconCatalogue.amazon.image, detail: "amazon", amount: 250),
						.init(cellLogo: .IconCatalogue.netflix.image, detail: "netflix", amount: 50),
						.init(cellLogo: .IconCatalogue.zomato.image, detail: "zomato", amount: 80)]
	}
	
	public func loadData() {
		view?.reloadTableWithDataSource(buildDatasource())
	}
	
	//MARK: - Views
	private func circleChart(_ to: Float) -> UIView {
		GenericCircularProgressBar(frame: .init(origin: .zero, size: .init(squared: 22)),
								   radiusOffset: -1,
								   strokeColor: .parkGreen500,
								   strokeEnd: CGFloat(to),
								   animateStrokeEnd: false)
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
	
	//MARK: - Sections
	
	private var cardSection: TableSection {
		let card: CardModel = .init(bankName: "Emirates NBD", name: "Krishna Venkatramani")
		let cardTableCell = TableRow<CardViewTableCell>(.init(card: card, action: {
			CardStorage.selectedCard = card
			NotificationCenter.default.post(name: .showCard, object: nil)
		}))
		let moreButton = moreButton(titleString: "view more") {
			print("Clicked on more!")
		}
		return .init(rows: [cardTableCell] + txnCells + [moreButton], title: "Cards")
	}
	
	private var txnCells: [TableCellProvider] {
		transactions?.compactMap { TableRow<TransactionCell>(.init(transaction: $0)) } ?? []
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

	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [cardSection, summarySection, creditScoreView])
	}
}
