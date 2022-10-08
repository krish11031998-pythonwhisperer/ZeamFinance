//
//  ZeamOfferViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

class ZeamOfferViewModel {
	
	public var view: AnyTableView?
	private var offers: [OfferViewModel]?
	
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
		return .init(rows: cells,
					 title: "Trending Offers Section")
	}
	
	private var exclusiveOffersSection: TableSection {
		let cells =  OfferViewModel.testCases.compactMap { TableRow<ExclusiveOfferTableCell>($0) }
		return .init(rows: cells,
					 title: "Exclusive Offers Section")
	}
	
	private var exclusiveLargeOffersSection: TableSection {
		let cells = OfferViewModel.testCases.compactMap { CollectionItem<ExclusiveOfferCollectionCell>($0) }
		return .init(rows: [TableRow<ExclusiveOfferCollection>(.init(cells: cells,
																size: .init(width: .totalWidth, height: 250),
																cellSize: .init(width: 168, height: 217)))],
					 title: "Exclusive Offers (Large) Section")
	}
	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [highlightOffersSection, trendingOffersSection, exclusiveLargeOffersSection])
	}
}
