//
//  UserSummaryView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 16/10/2022.
//

import Foundation
import UIKit

struct EmptyModel {
}

class UserInfoView: UIView {
	
	private lazy var userInfo: UIStackView = { .HStack(spacing: 10) }()
	private lazy var userBalance: DualLabel = { .init() }()
	private lazy var mainStack: UIStackView = { .VStack(spacing: 10) }()
	private lazy var userAssets: UIStackView = { .HStack(spacing: 10) }()
	private var addGradient: Bool = false
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		if !addGradient {
			addGradientView(colors: [.parkGreen300, .parkGreen600], frame: frame)
			addGradient.toggle()
		}
	}
	
	private func setupView() {
		[userInfo, userBalance].addToView(mainStack)
		addSubview(mainStack)
		setFittingConstraints(childView: mainStack, insets: .init(vertical: 15, horizontal: 10))
		setupUserInfoView(userName: "Krishna")
		setupBalanceLabel()
		setupAssets()
		backgroundColor = .clear
		clippedCornerRadius = 20
	}
	
	private func setupUserInfoView(userName: String) {
		let userNameGreetingLabel = DualLabel()
		let greeting: RenderableText = "Hello, \(userName)".bold(color: .textColorInverse, size: 20)
		let subtitle: RenderableText = "Welcome back to Zeam!".regular(color: .textColorInverse, size: 12)
		userNameGreetingLabel.configureLabel(title: greeting, subTitle: subtitle, config: .init(spacing: 8))
		
		let imgView = UIImageView(frame: .init(origin: .zero, size: .init(squared: 48)))
		imgView.clippedCornerRadius = 8
		imgView.backgroundColor = .popWhite500
		imgView.setFrame(width: 48)
		imgView.circleFrame = .init(origin: .zero, size: .init(squared: 48))
		
		userInfo.setHeight(height: 48, priority: .required)
		userInfo.removeChildViews()
		
		[userNameGreetingLabel, .spacer(), imgView].addToView(userInfo)
	}
	
	private func setupBalanceLabel() {
		let label = DualLabel()
		let balanceText: RenderableText = String(format: "$ %.2f", Float.random(in: 100..<1000)).bold(color: .textColorInverse, size: 30)
		label.configureLabel(title:"Your Balance".medium(color: .textColorInverse, size: 12) ,
							 subTitle: balanceText)
		mainStack.addArrangedSubview(label)
	}
	
	private func setupAssets() {
		userAssets.alignment = .center
		[UIImage.IconCatalogue.coins, UIImage.IconCatalogue.vouchers].forEach {
			let view = ProfileAsset()
			view.configureView(img: $0.image, text: "\(Int.random(in: 100..<10000))")
			userAssets.addArrangedSubview(view)
		}
		userAssets.addArrangedSubview(.spacer())
		mainStack.addArrangedSubview(userAssets)
	}
	
	public func configure(with model: EmptyModel) {
		
	}
}
