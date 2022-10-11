//
//  ZeamOfferViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

class ZeamOfferViewModel {
	
	public weak var view: AnyTableView?
	private var offers: [OfferViewModel]?
	private var selectedOffer: OfferType = .traveling
	
	public func loadData() {
		offers = OfferViewModel.testCases
		view?.reloadTableWithDataSource(buildDatasource() )
	}
	
	private var highlightOffersSection: TableSection {
		let cells = OfferViewModel.testCases.compactMap { CollectionItem<HighlightOfferCollectionCell>($0) }
		return .init(rows: [TableRow<CollectionTableCell>(.init(cells: cells,
																size: .init(width: .totalWidth, height: 485),
																cellSize: .init(width: 288, height: 485)))],
					 title: "Highlight Offers")
	}
	
	private var trendingOffersSection: TableSection {
		let cells = OfferViewModel.testCases.compactMap { TableRow<TrendingOfferTableCell>($0) }
		return .init(rows: personalizedOfferSection + cells,
					 title: "Personalized Offers")
	}
	
	private var exclusiveOffersSection: TableSection {
		let cells =  OfferViewModel.testCases.compactMap { TableRow<ExclusiveOfferTableCell>($0) }
		return .init(rows: cells, title: "Exclusive Offers")
	}
	
	private var exclusiveLargeOffersSection: TableSection {
		let cells = OfferViewModel.testCases.compactMap { CollectionItem<ExclusiveOfferCollectionCell>($0) }
		return .init(rows: [TableRow<ExclusiveOfferCollection>(.init(cells: cells,
																size: .init(width: .totalWidth, height: 250),
																cellSize: .init(width: 168, height: 217)))],
					 title: "Exclusive Offers")
	}
	
	private var personalizedOfferSection: [TableCellProvider] {
		let offerType: [CollectionCellProvider] = OfferType.allCases.filter { $0 != .none }.compactMap {offer in
			let view = offer.blobButton(.none) {
				self.selectedOffer = offer
				print("(DEBUG) selectedOffer : ", offer)
				self.view?.refreshTableView()
			}
			return CollectionItem<CustomCollectionCell>(.init(view: view, inset: .zero))
		}
		return [TableRow<CollectionTableCell>(.init(cells: offerType,
													size: .init(width: .totalWidth, height: 50),
													cellSize: .init(squared: 10),
													automaticDimension: true))]
	}
	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [highlightOffersSection, trendingOffersSection, exclusiveLargeOffersSection])
	}
}
