//
//  HomeViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 07/10/2022.
//

import Foundation
import UIKit

class HomeViewModel {
	
	weak var view: AnyTableView?
		
	public func loadData() {
		view?.reloadTableWithDataSource(buildDatasource())
	}
	
	private var cardSection: TableSection {
		let card: CardModel = .init(bankName: "Emirates NBD", name: "Krishna Venkatramani")
		let cardTableCell = TableRow<CardViewTableCell>(.init(card: card) { CardStorage.selectCard(card) })
		return .init(rows: [cardTableCell], title: "Cards")
	}
	
	private var recentTransactions: TableSection {
		let txns: [TransactionModel] = [.init(cellLogo: .IconCatalogue.amazon.image, detail: "amazon", amount: 250),
										.init(cellLogo: .IconCatalogue.netflix.image, detail: "netflix", amount: 50),
										.init(cellLogo: .IconCatalogue.zomato.image, detail: "zomato", amount: 80)]
		let moreCell = CustomButton()
		moreCell.configureButton(.init(title: "view more".bold(size: 13),
									   buttonType: .slender,
									   buttonStyling: .init(borderColor: .surfaceBackgroundInverse), action: showTransations))
		moreCell.setWidth(width: moreCell.compressedSize.width, priority: .required)

		let stack: UIStackView = .HStack(subViews: [moreCell, .spacer()],spacing: 0, alignment: .center)
		return .init(rows: txns.compactMap { TableRow<TransactionCell>(.init(transaction: $0)) } + [TableRow<CustomTableCell>(.init(view: stack, inset: .init(by: 10)))],
					 title: "Recent Transactions")
	}
	
	private var exclusiveOffersSection: TableSection {
		let moreCell = CustomButton()
		moreCell.configureButton(.init(title: "view more".bold(size: 13),
									   buttonType: .slender,
									   buttonStyling: .init(borderColor: .surfaceBackgroundInverse), action: showOffers))
		moreCell.setWidth(width: moreCell.compressedSize.width, priority: .required)

		let stack: UIStackView = .HStack(subViews: [moreCell, .spacer()],spacing: 0, alignment: .center)
		
		let cells = OfferViewModel.testCases.limitTo(to: 3).compactMap { TableRow<TrendingOfferTableCell>($0) }
		return .init(rows: cells + [TableRow<CustomTableCell>(.init(view: stack, inset: .init(by: 10)))],
					 title: "Trending Offers")
	}
	
	private var creditScoreView: TableSection {
		let creditScoreView = CreditScoreView()
		creditScoreView.configureView(.init(score: 750))
		return .init(rows: [TableRow<CustomTableCell>(.init(view: creditScoreView, inset: .init(by: 10)))],
															title: "Credit Card Score")
	}
	
	private var billSection: TableSection {
		let moreBills = CustomButton()
		moreBills.configureButton(.init(title: "View All Bills".bold(size: 13),
										buttonType: .slender,
										buttonStyling: .init(borderColor: .surfaceBackgroundInverse), action: {
			print("(DEBUG) Clicked on view all bills")
		}))
		let stack = UIStackView.HStack(subViews: [moreBills, .spacer()], spacing: 0)
		let moreBillCell = TableRow<CustomTableCell>(.init(view: stack, inset: .init(by: 10)))
		return .init(rows: [TableRow<PaymentCardTableCell>(.person),moreBillCell], title: "Upcoming Bill")
	}

	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [cardSection, recentTransactions, billSection, exclusiveOffersSection])
	}
	
	//MARK: - Functional Handler
	
	private func showTransations() {
		NotificationCenter.default.post(name: .showAllTransactions, object: nil)
	}
	
	
	private func showOffers() {
		NotificationCenter.default.post(name: .showAllTrendingOffersTab, object: nil)
	}
}
