//
//  HighlightOfferCollectionCell.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 05/10/2022.
//

import Foundation
import UIKit

class HighlightOfferCollectionCell: ConfigurableCollectionCell {
	
	private lazy var view: HighlightOfferView = { .init() }()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	private func setupView() {
		contentView.addSubview(view)
		contentView.setFittingConstraints(childView: view, insets: .zero)
		view.setWidth(width: 288, priority: .needed)
		
	}
	
	func configure(with model: OfferViewModel) {
		view.configureView(model)
	}
	
}
