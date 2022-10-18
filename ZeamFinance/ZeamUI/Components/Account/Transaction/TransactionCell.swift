//
//  TransactionCell.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 06/10/2022.
//

import Foundation
import UIKit

class TransactionCell: ConfigurableCell {
	
	private var cellLogo: UIImageView = {
		let view = UIImageView()
		view.contentMode = .center
		view.backgroundColor = .popWhite500
		view.border(color: .surfaceBackgroundInverse, borderWidth: 0.4, cornerRadius: 8)
		return view
	}()
	private lazy var amountLabel: UILabel = { .init() }()
	private lazy var infoView: DualLabel = { .init() }()
	private lazy var cellBGView: UIView = {
		let view: UIView = .init()
		view.backgroundColor = userInterface == .light ? .popWhite300 : .popBlack300
		view.clippedCornerRadius = 12
		return view
	}()
	
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
		[cellBGView, stack].addToView(contentView)
		contentView.setFittingConstraints(childView: stack, insets: .init(by: 16))
		contentView.setFittingConstraints(childView: cellBGView, insets: .init(vertical: 4, horizontal: 10))
	}
	
	
	func configure(with model: TransactionCellModel) {
		let model = model.transaction
		cellLogo.configureImageView(.init(img: model.cellLogo.resized(size: .init(squared: 20)), size: .init(squared: 42)))
		infoView.configureLabel(title: model.detail.medium(size: 14), subTitle: model.date.medium(color: .popBlack100, size: 12))
		String(format: "$ %.2f", model.amount).semiBold(size: 14).render(target: amountLabel)
		backgroundColor = .surfaceBackground
		selectionStyle = .none
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		cellBGView.backgroundColor = userInterface == .light ? .popWhite300 : .popBlack300
	}
	
}
