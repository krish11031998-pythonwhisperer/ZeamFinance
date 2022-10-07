//
//  HighlightOfferView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 05/10/2022.
//

import Foundation
import UIKit

struct OfferViewModel {
	let brandLogo: UIImage?
	let brandLogoImage: String?
	let brand: String?
	let offerDescription: String
	let background: UIImage?
	let backgroundUrl: String?
	let category: String?
	
	init(brandLogo: UIImage? = nil,
		 brandLogoImage: String? = nil,
		 brand: String? = nil,
		 category: String? = nil,
		 offerDescription: String,
		 background: UIImage? = nil,
		 backgroundUrl: String? = nil) {
		self.brandLogo = brandLogo
		self.brandLogoImage = brandLogoImage
		self.brand = brand
		self.offerDescription = offerDescription
		self.background = background
		self.backgroundUrl = backgroundUrl
		self.category = category
	}
}

extension OfferViewModel{
	
	static var testCases: [OfferViewModel] {
		zip(UIImage.BrandCatalogue.allCases, UIImage.OfferCatalogue.allCases).compactMap {
			.init(brandLogo: $0.image,
				  brand: "FlipKart",
				  category: "entertainment",
				  offerDescription: "get 10% instant discount on purchase of products across fashion category. minimum transaction amount of ₹1750 and lorem ipsum",
				  background: $1.image)
		}
	}
	
	static var test: OfferViewModel {
		.init(brandLogo: .BrandCatalogue.brandLogoOne.image,
			  brand: "FlipKart",
			  category: "entertainment",
			  offerDescription: "get 10% instant discount on purchase of products across fashion category. minimum transaction amount of ₹1750 and lorem ipsum",
			  background: .OfferCatalogue.offerImageOne.image)
	}
	
	static var testTwo: OfferViewModel {
		.init(brand: "FlipKart", category: "entertainment",
			  offerDescription: "get 10% instant discount on purchase of products across fashion category. minimum transaction amount of ₹1750 and lorem ipsum",
			  background: .OfferCatalogue.offerImageTwo.image)
	}
	
	static var testThree: OfferViewModel {
		.init(brand: "FlipKart", category: "entertainment",
			  offerDescription: "get 10% instant discount on purchase of products across fashion category. minimum transaction amount of ₹1750 and lorem ipsum",
			  background: .OfferCatalogue.offerImageThree.image)
	}
	
	static var zeeTest: OfferViewModel {
		.init(brand: "Zee5", category: "entertainment",
			  offerDescription: "get 10% instant discount on purchase of products across fashion category. minimum transaction amount of ₹1750 and lorem ipsum")
	}
}

fileprivate extension UIImageView {
	func configImage(url: String? = nil, img: UIImage? = nil) {
		if let validImage = img {
			image = validImage
		} else if let validUrl = url {
			UIImage.loadImage(url: validUrl, at: self, path: \.image)
		}
	}
}

class HighlightOfferView: UIView {
	
	private lazy var brandLogo: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFill
		view.clipsToBounds = true
		view.setFrame(.init(squared: 56))
		view.backgroundColor = .popBlack500
		return view
	}()
	
	private lazy var backgroundImage: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFill
		view.backgroundColor = .popWhite100
		view.clipsToBounds = true
		return view
	}()
	
	private lazy var brandLabel: UILabel = { .init() }()
	
	private lazy var offerDetail: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		return label
	}()
	
	private lazy var button: CustomButton = {
		let button = CustomButton()
		button.configureButton(.init(title: "View Details".bold(size: 13),
									 trailingImg: .init(img: UIImage.buttonRightArrow)))
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	
	private func setupView() {
		let stack: UIStackView = .VStack(subViews: [brandLogo, brandLabel, offerDetail, .spacer(), button], spacing: 0,alignment: .leading)
		stack.setCustomSpacing(40, after: brandLogo)
		stack.setCustomSpacing(10, after: brandLabel)
		
		addSubview(backgroundImage)
		setFittingConstraints(childView: backgroundImage, insets: .zero)
		
		let colorGradientView: UIView = .init()
		colorGradientView.backgroundColor = .popBlack300.withAlphaComponent(0.5)
		addSubview(colorGradientView)
		setFittingConstraints(childView: colorGradientView, insets: .zero)
		
		addSubview(stack)
		setFittingConstraints(childView: stack, insets: .init(vertical: 30, horizontal: 20))
	}
	
	public func configureView(_ model: OfferViewModel) {
		brandLogo.configImage(url: model.brandLogoImage, img: model.brandLogo)
		backgroundImage.configImage(url: model.backgroundUrl, img: model.background)
		model.brand?.bold(size: 20).render(target: brandLabel)
		model.offerDescription.medium(color: .popWhite500, size: 14).render(target: offerDetail)
		
	}
}
