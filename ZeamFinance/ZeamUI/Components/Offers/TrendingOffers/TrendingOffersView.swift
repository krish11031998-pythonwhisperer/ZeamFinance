//
//  TrendingOffersView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 05/10/2022.
//

import Foundation
import UIKit

class TrendingOffersView: UIView {
	
	private lazy var offerImage: UIImageView = {
		let view = UIImageView()
		view.clipsToBounds = true
		view.contentMode = .scaleToFill
		view.backgroundColor = .popWhite100
		return view
	}()
	
	private lazy var brandLogo: UIImageView = {
		let view = UIImageView()
		view.clipsToBounds = true
		view.contentMode = .scaleToFill
		view.backgroundColor = .popBlack500
		return view
	}()
	
	private lazy var brandLabel: UILabel = { .init() }()
	private lazy var descriptionLabel: UILabel = { .init() }()
	private lazy var categoryLabel: UILabel = { .init() }()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	
	private func setupView() {
		let stack: UIStackView = .HStack(subViews: [imageView(), bodyStack()], spacing: 25)
		addSubview(stack)
		setFittingConstraints(childView: stack, insets: .zero)
	}
	
	private func imageView() -> UIImageView {
		offerImage.addSubview(brandLogo)
		offerImage.setFittingConstraints(childView: brandLogo, leading: 10, bottom: 10, width: 30, height: 30)
		offerImage.setFrame(.init(squared: 95))
		return offerImage
	}
	
	private func bodyStack() -> UIStackView {
		let stack: UIStackView = .VStack(subViews: [brandLabel, descriptionLabel, categoryLabel], spacing: 10)
		return stack
	}
	
	
	public func configureView(_ model: OfferViewModel) {
		model.brand?.bold(size: 12).render(target: brandLabel)
		model.offerDescription.medium(size: 12).render(target: descriptionLabel)
		descriptionLabel.numberOfLines = 2
		model.category?.medium(size: 11).render(target: categoryLabel)
		
		
		offerImage.configureImageView(.init(img: model.background, url: model.backgroundUrl))
		brandLogo.configureImageView(.init(img: model.brandLogo, url: model.brandLogoImage))
	}
	
}
