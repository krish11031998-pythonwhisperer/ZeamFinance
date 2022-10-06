//
//  TrendingOfferView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 05/10/2022.
//

import Foundation
import UIKit

class CategoriesView: UIView {
	private lazy var categoryLabel: UILabel = { .init() }()
	private lazy var imageView: UIImageView = {
		let view = UIImageView(frame: .init(origin: .zero, size: .init(width: 45, height: 61)))
		view.clipsToBounds = true
		view.backgroundColor = .popWhite100
		return view
	}()
	private lazy var offerCountLabel: UILabel = { .init() }()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	private func setupView() {
		let stack: UIStackView = .VStack(subViews: [.spacer(),categoryLabel, imageView], spacing: 7, alignment: .trailing)
		stack.setFittingConstraints(childView: categoryLabel, leading: 8)
		stack.setFittingConstraints(childView: imageView, leading: 25, height: 61)
		
		stack.backgroundColor = .surfaceBackgroundInverse
		
		let mainStack: UIStackView = .VStack(subViews: [stack, offerCountLabel],spacing: 10)
		
		addSubview(mainStack)
		setFittingConstraints(childView: mainStack, insets: .zero)
	}
	
	
	public func configureView(_ category: String, img: UIImage? = nil, imgUrl: String? = nil, offerCount: Int? = nil) {
		category.medium(color: .textColorInverse, size: 11).render(target: categoryLabel)
		"\(offerCount ?? 0) offer(s)".medium(size: 11).render(target: offerCountLabel)
		
		if let validImg = img {
			imageView.image = validImg
		} else if let validUrl = imgUrl {
			UIImage.loadImage(url: validUrl, at: imageView, path: \.image)
		}
	}
	
	
}
