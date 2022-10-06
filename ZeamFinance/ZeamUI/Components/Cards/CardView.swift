//
//  CardView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 06/10/2022.
//

import Foundation
import UIKit

struct CardModel {
	let bankName: String
	let cardNumber: String
	let name: String
	
	init(bankName: String, cardNumber: String = "1234 XXXX XXXX 2022", name: String) {
		self.bankName = bankName
		self.cardNumber = cardNumber
		self.name = name
	}
}

class CardView: UIView {
	
	private lazy var imgView: UIImageView = {
		let img = UIImageView(image: .IconCatalogue.cardLarge.image)
		img.contentMode = .scaleAspectFit
		img.clipsToBounds = true
		return img
	}()
	private lazy var bankDetails: DualLabel = { .init() }()
	private lazy var nameLabel: UILabel = { .init() }()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func setupStack() {
		let stack = UIStackView.VStack(subViews: [bankDetails, .spacer(), nameLabel], spacing: 0)
		stack.alignment = .leading
		imgView.addSubview(stack)
		imgView.setFittingConstraints(childView: stack, insets: .init(by: 20))
	}
	
	private func setupView() {
		imgView.image = imgView.image?.resized(size: bounds.size)
		addSubview(imgView)
		setFittingConstraints(childView: imgView, insets: .zero)
		setupStack()
	}
	
	public func configureCard(_ model: CardModel) {
		bankDetails.configureLabel(title: model.bankName.uppercased().bold(size: 13), subTitle: model.cardNumber.semiBold(size: 10))
		model.name.semiBold(size: 13).render(target: nameLabel)
	}
}
           
