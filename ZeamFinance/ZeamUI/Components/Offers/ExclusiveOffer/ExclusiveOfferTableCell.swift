//
//  ExclusiveOfferTableCell.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 05/10/2022.
//

import Foundation
import UIKit


class ExclusiveOfferTableCell: ConfigurableCell {
	
	private lazy var view: ExclusiveView = { .init() }()
	
	func configure(with model: OfferViewModel) {
		contentView.removeChildViews()
		contentView.addSubview(view)
		contentView.setFittingConstraints(childView: view, insets: .init(vertical: 5, horizontal: 10))
		view.configureView(model, .small)
		backgroundColor = .surfaceBackground
		selectionStyle = .none
	}
	
}
