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
		standardNavBar(title: "Offers".medium(size: 20))
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
		let cells = OfferViewModel.testCases.compactMap { CollectionItem<HighlightOfferCollectionCell>($0) }
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
	
	private func buildDatasource() -> TableViewDataSource{
		.init(sections: [spotlightOffersSection,
						 highlightOffersSection,
						 categoryOffersSection,
						 trendingOffersSection,
						 exclusiveOffersSection,
						 exclusiveLargeOffersSection])
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		guard let img = navigationItem.leftBarButtonItem?.image else { return }
		navigationItem.leftBarButtonItem?.image = img.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal)
	}
}
