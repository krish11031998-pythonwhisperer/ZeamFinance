//
//  AccountSummaryCards.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

struct AccountSummaryModel {
	let topView: UIView
	let title: String
	let subTitle: String
}

struct AccountSummmaryCellModel: ActionProvider {
	let model: AccountSummaryModel
	var action: Callback?
	
	init(model: AccountSummaryModel, action: Callback? = nil) {
		self.model = model
		self.action = action
	}
}

class AccountSummaryCard: UIView {

	private lazy var infoLabel: DualLabel = { .init() }()
	private lazy var mainStack: UIStackView = { .VStack(subViews: [infoLabel], spacing: 12, alignment: .leading) }()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	private func setupView() {
		addSubview(mainStack)
		setFittingConstraints(childView: mainStack, insets: .init(by: 15))
		backgroundColor = .popBlack300
	}
	
	public func configureView(model: AccountSummaryModel) {
		let topView = model.topView
		topView.setFrame(.init(squared: 22))
		mainStack.insertArrangedSubview(topView, at: 0)
		infoLabel.configureLabel(title: model.title.bold(color: .popWhite500, size: 13),
								 subTitle: model.subTitle.medium(color: .popBlack100, size: 11), config: .init(spacing: 4))
	}
}


class AccountSummaryTableCell: ConfigurableCell {
	
	private lazy var view: AccountSummaryCard = { .init() }()
	
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
		contentView.setFittingConstraints(childView: view, insets: .zero)
		backgroundColor = .surfaceBackground
		selectionStyle = .none
	}
	
	func configure(with model: AccountSummaryModel) {
		view.configureView(model: model)
	}
}


class AccountSummaryCollectionCell: ConfigurableCollectionCell {
	
	private lazy var view: AccountSummaryCard = { .init() }()

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
		contentView.setFittingConstraints(childView: view, insets: .zero)
		backgroundColor = .surfaceBackground
		contentView.clippedCornerRadius = 8
	}
	
	func configure(with model: AccountSummmaryCellModel) {
		view.configureView(model: model.model)
	}
}
