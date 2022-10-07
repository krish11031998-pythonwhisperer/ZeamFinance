//
//  TrendingOfferTableCell.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 05/10/2022.
//

import Foundation
import UIKit



class TrendingOfferTableCell: ConfigurableCell {
	
	private lazy var trendingView: TrendingOffersView = { .init() }()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	
	private func setupView() {
		contentView.addSubview(trendingView)
		contentView.setFittingConstraints(childView: trendingView, insets: .init(vertical: 10, horizontal: 10))
		backgroundColor = .surfaceBackground
		selectionStyle = .none
	}
	
	func configure(with model: OfferViewModel) {
		trendingView.configureView(model)
	}
	
}
