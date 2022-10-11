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

struct CardCellModel: ActionProvider {
	let card: CardModel
	var action: Callback?
}

class CardView: UIView {
	
	private lazy var imgView: UIImageView = {
		let img = UIImageView(image: .IconCatalogue.cardLarge.image)
		img.contentMode = .scaleAspectFill
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
		addSubview(imgView)
		addSubview(stack)
		setFittingConstraints(childView: imgView, insets: .zero)
		setFittingConstraints(childView: stack, insets: .init(by: 20))
		border(color: .surfaceBackgroundInverse, borderWidth: 0.25, cornerRadius: 12)
	}
	
	private func setupView() {
		setupStack()
	}
	
	public func configureCard(_ model: CardModel) {
		imgView.image = .IconCatalogue.cardLarge.image.resized(size: frame.size)
		bankDetails.configureLabel(title: model.bankName.uppercased().bold(color: .popWhite100, size: 13),
								   subTitle: model.cardNumber.semiBold(color: .popWhite100, size: 10))
		model.name.semiBold(color: .popWhite100, size: 13).render(target: nameLabel)
	}
}
           
class CardViewTableCell: ConfigurableCell {
	
	private lazy var view: CardView = { .init(frame: CGSize.init(width: .totalWidth, height: .totalWidth/1.75).frame) }()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func setupView() {
		contentView.addSubview(view)
		contentView.setFittingConstraints(childView: view, insets: .init(by: 10))
		view.setHeight(height: .totalWidth/1.75, priority: .needed)
		backgroundColor = .surfaceBackground
		selectionStyle = .none
	}
	
	func configure(with model: CardCellModel) {
		view.configureCard(model.card)
	}
}


class CardViewCollectionCell: ConfigurableCollectionCell {
	
	private lazy var view: CardView = { .init(frame: CGSize.init(width: .totalWidth, height: .totalWidth/1.75).frame) }()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func setupView() {
		contentView.addSubview(view)
		contentView.setFittingConstraints(childView: view, insets: .init(by: 10))
		backgroundColor = .surfaceBackground
	}
	
	func configure(with model: CardCellModel) {
		view.configureCard(model.card)
	}
}
