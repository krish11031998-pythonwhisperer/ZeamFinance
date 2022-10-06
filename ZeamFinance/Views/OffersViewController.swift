//
//  OffersViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 04/10/2022.
//

import Foundation
import UIKit

class OffersViewController: UIViewController {
	
	let tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.separatorStyle = .none
		return table
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		standardNavBar()
	}
	
	private func setupViews() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.reloadData(buildDatasource())
		tableView.backgroundColor = .surfaceBackground
		view.backgroundColor = .surfaceBackground
	}
	
	private var spotlightOffersSection: TableSection {
		let cells = Array(repeating:CollectionItem<SpotlightOffer>(.init()), count: 10)
		return .init(rows: [TableRow<CollectionTableCell>(.init(cells: cells, size: .init(width: .totalWidth, height: 60), cellSize: .init(squared: 60)))],
					 title: "Spotlight Offers")
	}
	
	private var highlightOffersSection: TableSection {
		let cells = Array(repeating:CollectionItem<HighlightOfferCollectionCell>(.test), count: 5)
		return .init(rows: [TableRow<CollectionTableCell>(.init(cells: cells,
																size: .init(width: .totalWidth, height: 485),
																cellSize: .init(width: 288, height: 485)))],
					 title: "Highlight Offers")
	}
	
	private var categoryOffersSection: TableSection {
		let cells = Array(repeating:CollectionItem<CategoryCollectionCell>(.init(category: "food")), count: 5)
		return .init(rows: [TableRow<CollectionTableCell>(.init(cells: cells, size: .init(width: .totalWidth, height: 125), cellSize: .init(width: 70, height: 125)))],
					 title: "Category Section")
	}
	
	private var trendingOffersSection: TableSection {
		let cells = Array(repeating:TableRow<TrendingOfferTableCell>(.zeeTest), count: 5)
		return .init(rows: cells,
					 title: "Trending Offers Section")
	}
	
	private var exclusiveOffersSection: TableSection {
		let cells = Array(repeating:TableRow<ExclusiveOfferTableCell>(.zeeTest), count: 5)
		return .init(rows: cells,
					 title: "Exclusive Offers Section")
	}
	
	private var exclusiveLargeOffersSection: TableSection {
		let cells = Array(repeating:CollectionItem<ExclusiveOfferCollectionCell>(.zeeTest), count: 5)
		return .init(rows: [TableRow<ExclusiveOfferCollection>(.init(cells: cells,
																size: .init(width: .totalWidth, height: 250),
																cellSize: .init(width: 168, height: 217)))],
					 title: "Exclusive Offers (Large) Section")
	}
	
	private func buildDatasource() -> TableViewDataSource{
		.init(sections: [spotlightOffersSection,
						 highlightOffersSection,
						 categoryOffersSection,
						 trendingOffersSection,
						 exclusiveOffersSection,
						 exclusiveLargeOffersSection])
	}
}
