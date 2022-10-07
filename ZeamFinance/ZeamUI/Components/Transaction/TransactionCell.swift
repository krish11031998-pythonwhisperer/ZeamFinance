//
//  TransactionCell.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 06/10/2022.
//

import Foundation
import UIKit

struct TransactionModel {
	let cellLogo: UIImage
	let detail: String
	let date: String
	let amount: Float
	
	init(cellLogo: UIImage, detail: String, date: String = Date.now.ISO8601Format(), amount: Float) {
		self.cellLogo = cellLogo
		self.detail = detail
		self.date = date
		self.amount = amount
	}
}

class TransactionCell: ConfigurableCell {
	
	private var cellLogo: UIImageView = {
		let view = UIImageView()
		view.contentMode = .center
		view.backgroundColor = .popWhite500
		view.border(color: .surfaceBackgroundInverse, borderWidth: 0.4, cornerRadius: 0)
		return view
	}()
	
	private lazy var amountLabel: UILabel = { .init() }()
	private lazy var infoView: DualLabel = { .init() }()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}

	private func setupView() {
		let chevronImage = UIImage.SystemCatalogue.chevronRight.image
							.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal)
							.resized(size: .init(squared: 16))
		let imgView = UIImageView(image: chevronImage)
		imgView.contentMode = .scaleAspectFit
		let stack = UIStackView.HStack(subViews: [cellLogo, infoView, amountLabel, imgView], spacing: 16)
		contentView.addSubview(stack)
		contentView.setFittingConstraints(childView: stack, insets: .init(vertical: 5, horizontal: 10))
	}
	
	
	func configure(with model: TransactionModel) {
		cellLogo.configureImageView(.init(img: model.cellLogo.resized(size: .init(squared: 20)), size: .init(squared: 42)))
		infoView.configureLabel(title: model.detail.medium(size: 14), subTitle: model.date.medium(color: .popBlack100, size: 12))
		String(format: "$ %.2f", model.amount).semiBold(size: 14).render(target: amountLabel)
		backgroundColor = .surfaceBackground
		selectionStyle = .none
	}
	
}
