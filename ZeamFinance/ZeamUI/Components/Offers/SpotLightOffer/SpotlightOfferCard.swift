//
//  SpotlightOfferCard.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 04/10/2022.
//

import Foundation
import UIKit

struct SpotlightOfferModel {
	let img: UIImage?
	let url: String?
	
	init(img: UIImage? = nil, url: String? = nil) {
		self.img = img
		self.url = url
	}
}

class SpotlightOffer: ConfigurableCollectionCell {
	private lazy var imgView: UIImageView = {
		let imgView = UIImageView()
		imgView.cornerFrame = .init(origin: .zero, size: .init(squared: 48))
		imgView.clipsToBounds = true
		imgView.contentMode = .scaleAspectFill
		imgView.backgroundColor = .popBlack100
		return imgView
	}()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	
	private func setupViews() {
		contentView.addSubview(imgView)
		imgView.setFrame(.init(squared: 48))
		contentView.setFittingConstraints(childView: imgView, insets: .init(by: 6))
	}
	
	public func configure(with model: SpotlightOfferModel) {
		if let img = model.img {
			imgView.image = img
		} else if let url = model.url {
			UIImage.loadImage(url: url, at: imgView, path: \.image)
		}
	}
}
