//
//  WalletHeaderView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 10/10/2022.
//

import Foundation
import UIKit

fileprivate extension TransactionWeeklyModel {
	
	var normalizedHeight: [CGFloat] {
		daily.compactMap{_ in CGFloat(Float.random(in: 100..<1000)) }.normalize()
	}
}

class WalletHeaderView: UIView {
	
	private let innerStackInset: CGFloat = 10
	private lazy var stackWidth: CGFloat = { .totalWidth - (2 * innerStackInset) }()
	private let stackHeight: CGFloat = 200
	private let indicatorWidth: CGFloat = 20
	private lazy var stack: UIStackView = { .HStack(spacing: 0, alignment: .center) }()
	private lazy var mainStack: UIStackView = { .VStack(spacing: 25, alignment: .leading) }()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func setupView() {
		["Weekly Spending".sectionHeader(size: 25).generateLabel, stack].forEach(mainStack.addArrangedSubview(_:))
		addSubview(mainStack)
		mainStack.setFittingConstraints(childView: stack, leading: 0, trailing: 0)
		stack.distribution = .equalCentering
		stack.setHeight(height: 200, priority: .required)
		setFittingConstraints(childView: mainStack, insets: .init(by: innerStackInset), priority: .needed)
	}
	
	private func addBackgroundView() {
		let view = UIView()
		view.addBlurView()
		addSubview(view)
		setFittingConstraints(childView: view, insets: .init(by: 10), priority: .needed)
		view.addBlurView()
		view.cornerRadius = 8
		view.clipsToBounds = true
	}
	
	public func configureHeaderView(_ weekly: TransactionWeeklyModel) {
		stack.removeChildViews()
		weekly.normalizedHeight.compactMap { $0 * stackHeight }.forEach { h in
			let size: CGSize = .init(width: indicatorWidth, height: h == 0 ? 10 : h)
			let lineView = UIView()
			lineView.backgroundColor = .popBlack100
			let view = UIView()
			view.backgroundColor = .surfaceBackgroundInverse
			view.setFrame(size)
			view.circleFrame = size.frame
			let chartIndicator = UIView()
			[lineView, view].forEach {
				chartIndicator.addSubview($0)
			}
			chartIndicator.setFittingConstraints(childView: view, centerY: 0)
			chartIndicator.setFittingConstraints(childView: lineView,top: 0, bottom: 0, width: 0.5, centerX: 0)
			chartIndicator.setFrame(width: indicatorWidth, height: stackHeight)
			stack.addArrangedSubview(chartIndicator)
		}
	}
}
