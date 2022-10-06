//
//  ExclusiveOfferCollectionCell.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 05/10/2022.
//

import Foundation
import UIKit

typealias ExclusiveOfferCollection = CollectionTableCell

class ExclusiveOfferCollectionCell: ConfigurableCollectionCell {
	
	private lazy var view: ExclusiveView = { .init() }()
	
	func configure(with model: OfferViewModel) {
		contentView.removeChildViews()
		contentView.addSubview(view)
		contentView.setFittingConstraints(childView: view, insets: .zero)
		view.configureView(model, .big)
	}
	
}
