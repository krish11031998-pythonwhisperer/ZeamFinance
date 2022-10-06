//
//  ExclusiveOfferVioew.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 05/10/2022.
//

import Foundation
import UIKit

enum ExclusiveViewType {
	case big
	case small
}

class ExclusiveView: UIView {
	
	private lazy var imgView: UIImageView = {
		let view = UIImageView()
		view.backgroundColor = .popWhite100
		view.clipsToBounds = true
		return view
	}()
	private lazy var mainStack: UIStackView = { .init() }()
	private lazy var brandLogo: UILabel = { .init() }()
	private lazy var descriptionLabel: UILabel = { .init() }()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func bodyView() -> UIView {
		let arrowImage = UIImageView(image: UIImage.buttonRightArrow)
		arrowImage.setFrame(.init(width: 20, height: 8))
		descriptionLabel.numberOfLines = 0
		let stack: UIStackView = .VStack(subViews: [brandLogo, descriptionLabel, arrowImage].compactMap { $0 } ,spacing: 8, alignment: .leading)
		descriptionLabel.numberOfLines = 2
		return stack
	}
	
	private func setupView() {
		[imgView, bodyView()].forEach(mainStack.addArrangedSubview(_:))
		mainStack.spacing = 16
		addSubview(mainStack)
		setFittingConstraints(childView: mainStack, insets: .zero)
	}
	
	public func configureView(_ model: OfferViewModel, _ cardType: ExclusiveViewType) {
		model.brand?.uppercased().bold(size: 12).render(target: brandLogo)
		model.offerDescription.medium(size: 14).render(target: descriptionLabel)
		if cardType == .big {
			mainStack.axis = .vertical
			mainStack.spacing = 8
			imgView.configureImageView(.init(img: model.brandLogo, url: model.brandLogoImage))
			imgView.setHeight(height: 132, priority: .needed)
		} else if cardType == .small {
//			imgView.setFrame(.init(squared: 75))
			imgView.configureImageView(.init(img: model.brandLogo, url: model.brandLogoImage, size: .init(squared: 75)))
		}
	}
	
}
