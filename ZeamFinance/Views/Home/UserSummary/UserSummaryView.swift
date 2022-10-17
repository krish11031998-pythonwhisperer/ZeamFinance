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
	private lazy var quickActions: UIStackView = { .VStack(spacing: 8) }()
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
		[userInfo, userBalance, userAssets, quickActions].addToView(mainStack)
		mainStack.setCustomSpacing(25, after: userInfo)
		mainStack.setCustomSpacing(25, after: userAssets)
		addSubview(mainStack)
		setFittingConstraints(childView: mainStack, insets: .init(vertical: 15, horizontal: 10))
		setupUserInfoView(userName: "Krishna")
		setupBalanceLabel()
		setupAssets()
		setupQuickAction()
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
		let balanceText: RenderableText = String(format: "$ %.2f", Float.random(in: 100..<1000)).bold(color: .textColorInverse, size: 30)
		userBalance.configureLabel(title:"Your Balance".medium(color: .textColorInverse, size: 12) ,
							 subTitle: balanceText)
	}
	
	private func setupAssets() {
		userAssets.alignment = .center
		userAssets.removeChildViews()
		[UIImage.IconCatalogue.coins, UIImage.IconCatalogue.vouchers].forEach {
			let view = ProfileAsset()
			view.configureView(img: $0.image, text: "\(Int.random(in: 100..<10000))")
			userAssets.addArrangedSubview(view)
		}
		userAssets.addArrangedSubview(.spacer())
	}
	
	private func setupQuickAction() {
		let label = "Quick Actions".medium(color: .textColorInverse, size: 12).generateLabel
		let stack = UIStackView.HStack(spacing: 8)
		stack.alignment = .center
		["Receive", "Sell", "Pay"].map {
			let view = $0.medium(size: 12).generateLabel
			return view.blobify(backgroundColor: .surfaceBackground, edgeInset: .init(vertical: 7.5, horizontal: 12), borderColor: .clear, borderWidth: 0, cornerRadius: 12)
		}.addToView(stack)
		stack.addArrangedSubview(.spacer())
		[label, stack].addToView(quickActions)
		
	}
	
	public func configure(with model: EmptyModel) {
		
	}
}
