//
//  HomeViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 07/10/2022.
//

import Foundation
import UIKit

fileprivate extension PaymentCardModel {
	
	static var dewa: PaymentCardModel {
		.init(billCompany: "DEWA",
			  billDescription: "Utility Bill",
			  amount: Float.random(in: 100..<2000),
			  billCompanyLogo: .init(named: "DEWAImage") ?? .solid(color: .black), type: .bill)
	}
	
	static var person: PaymentCardModel {
		.init(billCompany: "John",
			  billDescription: "Dinner",
			  amount: Float.random(in: 50..<100),
			  billCompanyLogo: .init(named: "person") ?? .solid(color: .black),
			  type: .payment)
	}
	
	static var installment: PaymentCardModel {
		.init(billCompany: "Apple Inc.",
			  billDescription: "MacBook Pro",
			  amount: 2000,
			  billCompanyLogo: .init(named: "appleLogo") ?? .solid(color: .clear),
			  installmentsCount: 5,
			  totalInstallments: 12,
			  type: .installment)
	}
}

class HomeViewModel {
	
	var view: AnyTableView?
		
	public func loadData() {
		view?.reloadTableWithDataSource(buildDatasource())
	}
	
	private var cardSection: TableSection {
		let cardTableCell = TableRow<CardViewTableCell>(.init(bankName: "Emirates NBD", name: "Krishna Venkatramani"))
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
		moreCell.setWidth(width: moreCell.compressedSize.width, priority: .required)

		let stack: UIStackView = .HStack(subViews: [moreCell, .spacer()],spacing: 0, alignment: .center)
		return .init(rows: txns.compactMap { TableRow<TransactionCell>(.init(transaction: $0)) } + [TableRow<CustomTableCell>(.init(view: stack, inset: .init(by: 10)))],
					 title: "Recent Transactions")
	}
	
	private var exclusiveOffersSection: TableSection {
		let moreCell = CustomButton()
		moreCell.configureButton(.init(title: "view more".bold(size: 13),
									   buttonType: .slender,
									   buttonStyling: .init(borderColor: .white)))
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
		let img: UIImage =  .init(named: "DEWAImage") ?? .solid(color: .black)
		let cells = [PaymentCardModel.dewa, PaymentCardModel.person, PaymentCardModel.installment].compactMap { CollectionItem<PaymentCardCollectionCell>($0)}
		return .init(rows: [TableRow<CollectionTableCell>(.init(cells: cells,
																cellSize: .init(width: 225, height: 300)))], title: "Upcoming Bills")
	}

	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [cardSection, recentTransactions, billSection, creditScoreView, exclusiveOffersSection])
	}
	
}
