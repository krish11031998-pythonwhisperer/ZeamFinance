//
//  TrendingOfferCollectionCell.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 05/10/2022.
//

import Foundation
import UIKit

struct CategoryCollectionCellModel {
	let category: String
	let img: UIImage?
	let imgUrl: String?
	let offerCount: Int?
	
	init(category: String, img: UIImage? = nil, imgUrl: String? = nil, offerCount: Int? = nil) {
		self.category = category
		self.img = img
		self.imgUrl = imgUrl
		self.offerCount = offerCount
	}
}

class CategoryCollectionCell: ConfigurableCollectionCell {
	
	private lazy var view: CategoriesView = { .init() }()
	
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
	}
	
	func configure(with model: CategoryCollectionCellModel) {
		view.configureView(model.category, img: model.img, imgUrl: model.imgUrl, offerCount: model.offerCount)
	}
}
