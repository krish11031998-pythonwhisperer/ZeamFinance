//
//  CreditScore.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 06/10/2022.
//

import Foundation
import UIKit

struct CreditScorceModel {
	let score: Int
	let cardNumber: Int
	
	init(score: Int, cardNumber: Int = Int.random(in: 1..<4)) {
		self.score = score
		self.cardNumber = cardNumber
	}
}


class CreditScoreView: UIView {
	private lazy var progressBar: SphericalProgressBars = {
		let progressBar = SphericalProgressBars(frame: CGSize(squared: 100).frame, lineWidth: 7.5)
		progressBar.setFrame(.init(squared: 100))
		return progressBar
	}()
	private lazy var infoView: UIStackView = { .VStack(spacing: 10, alignment: .leading) }()
	private lazy var creditScore: DualLabel = { .init() }()
	private lazy var button: CustomButton = { .init() }()
	
	private lazy var infoStack: UIStackView = { .VStack(spacing: 10, alignment: .leading) }()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func color(score: Int) -> UIColor {
		switch score {
		case 0..<300 :
			return .error500
		case 300..<600:
			return .warning500
		case 600..<900:
			return .success500
		default:
			return .clear
		}
	}
	
	private func scoreIndicator(_ score: Int) -> RenderableText {
		switch score {
		case 0..<300 :
			return "Bad".bold(color: color(score: score), size: 14)
		case 300..<600:
			return "Average".bold(color: color(score: score), size: 14)
		case 600..<900:
			return "Good".bold(color: color(score: score), size: 14)
		default:
			return "None".bold(color: color(score: score), size: 14)
		}
	}
	
	private func setupView() {
		[creditScore,.spacer(), button].forEach(infoView.addArrangedSubview(_:))
		let stack = UIStackView.HStack(subViews: [progressBar, infoView], spacing: 40, alignment: .top)
		stack.setFittingConstraints(childView: infoView, bottom: 0)
		stack.distribution = .fillProportionally
		button.configureButton(.init(title: "View Report".bold(size: 13), buttonType: .stroke(inset: .init(vertical: 8, horizontal: 14))))
		addSubview(stack)
		setFittingConstraints(childView: stack, insets: .init(by: 30))
		backgroundColor = .surfaceBackground
		border(color: .popBlack100, borderWidth: 1, cornerRadius: 0)
	}
	
	public func configureView(_ model: CreditScorceModel) {
		progressBar.configureView(model.score)
		creditScore.configureLabel(title: scoreIndicator(model.score),
								   subTitle: "review activity on your \(model.cardNumber) cards".semiBold(size: 14),
								   config: .init(subTitleNumberOfLines: 0, spacing: 6))
	}
}

