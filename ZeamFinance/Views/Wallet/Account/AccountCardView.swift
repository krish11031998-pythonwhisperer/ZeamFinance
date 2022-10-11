//
//  AccountView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 11/10/2022.
//

import Foundation
import UIKit

class AccountCardView: UIView {
	
	private lazy var currencyName: DualLabel = { .init() }()
	private lazy var currencyAmount: UILabel = { .init() }()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func setupView() {
		let stack = UIStackView.HStack(subViews: [currencyName, .spacer(), currencyAmount], spacing: 12)
		addSubview(stack)
		setFittingConstraints(childView: stack, insets: .init(by: 15))
		addBlurView()
		cornerRadius = 12
		clipsToBounds = true
	}
	
	public func configureView(account: AccountModel) {
		currencyName.configureLabel(title: account.name.medium(size: 15), subTitle: account.accountId.regular(size: 10))
		String(format:"\(account.currency) %.2f", account.balance).medium(size: 15).render(target: currencyAmount)
	}
}


class AccountCardTableCell: ConfigurableCell {
	
	private lazy var view: AccountCardView = { .init() }()
	
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
		contentView.setFittingConstraints(childView: view, insets: .init(vertical: 5, horizontal: 10))
		selectionStyle = .none
		backgroundColor = .surfaceBackground
	}
	
	func configure(with model: AccountCellModel) {
		view.configureView(account: model.account)
	}
	
}
