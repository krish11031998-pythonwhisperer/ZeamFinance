//
//  HomeViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 07/10/2022.
//

import Foundation
import UIKit

class HomeViewModel {
	
	var view: AnyTableView?
		
	public func loadData() {
		view?.reloadTableWithDataSource(buildDatasource())
	}
	
	private var cardSection: TableSection {
		let cardView = CardView(frame: .init(origin: .zero, size: .init(width: .totalWidth, height: .totalWidth/1.75)))
		cardView.configureCard(.init(bankName: "Emirates NBD", name: "Krishna Venkatramani"))
		let cardTableCell = TableRow<CustomTableCell>(.init(view: cardView, inset: .init(top: 0, left: 8, bottom: 20, right: 8)))
		
		return .init(rows: [cardTableCell], title: "Most Used Card")
	}
	
	private var recentTransactions: TableSection {
		let txns: [TransactionModel] = [.init(cellLogo: .IconCatalogue.amazon.image, detail: "amazon", amount: 250),
										.init(cellLogo: .IconCatalogue.netflix.image, detail: "netflix", amount: 50),
										.init(cellLogo: .IconCatalogue.zomato.image, detail: "zomato", amount: 80)]
		let moreCell = CustomButton()
		moreCell.configureButton(.init(title: "view more".bold(size: 13),
									   buttonType: .slender,
									   buttonStyling: .init(borderColor: .white)))
		let view = UIView()
		view.addSubview(moreCell)
		view.setFittingConstraints(childView: moreCell, top: 10, leading: 10, bottom: 10)
		return .init(rows: txns.compactMap { TableRow<TransactionCell>($0) } + [TableRow<CustomTableCell>(.init(view: view, inset: .zero))],
					 title: "Recent Transactions")
	}
	
	private var exclusiveOffersSection: TableSection {
		let moreCell = CustomButton()
		moreCell.configureButton(.init(title: "view more".bold(size: 13),
									   buttonType: .slender,
									   buttonStyling: .init(borderColor: .white)))
		let view = UIView()
		view.addSubview(moreCell)
		view.setFittingConstraints(childView: moreCell, top: 10, leading: 10, bottom: 10)
		let cells = OfferViewModel.testCases.limitTo(to: 3).compactMap { TableRow<TrendingOfferTableCell>($0) }
		return .init(rows: cells + [TableRow<CustomTableCell>(.init(view: view, inset: .zero))],
					 title: "Trending Offers")
	}
	
	private var creditScoreView: TableSection {
		let creditScoreView = CreditScoreView()
		creditScoreView.configureView(.init(score: 750))
		let view = UIView()
		view.addSubview(creditScoreView)
		view.setFittingConstraints(childView: creditScoreView, insets: .init(by: 10))
		return .init(rows: [TableRow<CustomTableCell>(.init(view: view, inset: .zero))],
															title: "Credit Card Score")
	}

	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [cardSection, recentTransactions, creditScoreView, exclusiveOffersSection])
	}
	
}
