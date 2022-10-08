//
//  HomeHeaderView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 07/10/2022.
//

import Foundation
import UIKit

class HomeHeaderView: UIView {
	
	private lazy var titleLabel: DualLabel = { .init() }()
	private lazy var mainStack: UIStackView =  { .VStack(subViews: [titleLabel] ,spacing: 12) }()
	private lazy var userAssets: UIStackView = { .HStack(spacing: 10) }()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupViews()
	}
	
	private func setupViews() {
		addSubview(mainStack)
		setFittingConstraints(childView: mainStack, insets: .init(vertical: 20, horizontal: 10))

		userAssets.alignment = .center
		[UIImage.IconCatalogue.coins, UIImage.IconCatalogue.vouchers].forEach {
			let view = ProfileAsset()
			view.configureView(img: $0.image, text: "\(Int.random(in: 100..<10000))")
			userAssets.addArrangedSubview(view)
		}
		userAssets.addArrangedSubview(.spacer())
		mainStack.addArrangedSubview(userAssets)
	}
	
	
	func configureHeader() {
		titleLabel.configureLabel(title: "hello Krish".sectionHeader(size: 30),
								  subTitle: "Keep track of your credit card spending".medium(size: 18))
	}
}
