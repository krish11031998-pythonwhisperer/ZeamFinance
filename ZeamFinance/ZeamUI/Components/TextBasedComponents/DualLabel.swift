//
//  DualLabel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 06/10/2022.
//

import Foundation
import UIKit

struct DualLabelConfig {
	let alignment: UIStackView.Alignment
	let axis: NSLayoutConstraint.Axis
	let titleNumberOfLines: Int
	let subTitleNumberOfLines: Int
	let spacing: CGFloat
	
	init(alignment: UIStackView.Alignment = .leading,
		 axis: NSLayoutConstraint.Axis = .vertical,
		 titleNumberOfLines: Int = 1,
		 subTitleNumberOfLines: Int = 1,
		 spacing: CGFloat = 8) {
		self.alignment = alignment
		self.axis = axis
		self.titleNumberOfLines = titleNumberOfLines
		self.subTitleNumberOfLines = subTitleNumberOfLines
		self.spacing = spacing
	}
}

class DualLabel: UIView {
	
	private lazy var titleLabel: UILabel = { .init() }()
	private lazy var subTitleLabel: UILabel = { .init() }()
	private lazy var mainStack: UIStackView = { .init() }()
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
//		setupView()
	}
	
	private func setupView() {
		[titleLabel, subTitleLabel].addToView(mainStack)
		addSubview(mainStack)
		setFittingConstraints(childView: mainStack, insets: .zero)
	}
	
	public func configureLabel(title: RenderableText,
							   subTitle: RenderableText,
							   config: DualLabelConfig = .init()) {
		title.render(target: titleLabel)
		subTitle.render(target: subTitleLabel)
		mainStack.alignment = config.alignment
		mainStack.axis = config.axis
		mainStack.distribution = .fill
		mainStack.spacing = config.spacing
		subTitleLabel.numberOfLines = config.subTitleNumberOfLines
		titleLabel.numberOfLines = config.titleNumberOfLines
	}
	
}
