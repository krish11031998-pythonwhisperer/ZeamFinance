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
	private lazy var currencyAmount: DualLabel = { .init() }()
	private lazy var accountSymbol: UILabel =  { .init() }()
	private lazy var progressView: ProgressBar = {
		let progressbar = ProgressBar(fillColor: .surfaceBackgroundInverse)
		return progressbar
	}()
	private var progress: CGFloat?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func setupView() {
		let stack = UIStackView.VStack(subViews: [currencyName, .spacer(), currencyAmount, progressView], spacing: 12)
		progressView.setHeight(height: 7.5, priority: .required)
		addSubview(stack)
		setFittingConstraints(childView: stack, insets: .init(by: 15))
		clippedCornerRadius = 12
		border(color: .surfaceBackgroundInverse, borderWidth: 0.75, cornerRadius: 12)
	}
	
	public func configureView(account: AccountModel) {
		currencyName.configureLabel(title: account.name.medium(size: 15), subTitle: account.accountId.regular(size: 10))
		currencyAmount.configureLabel(title: "Balance".medium(size: 12), subTitle: String(format:"$ %.2f", account.balance).medium(size: 25))
		account.currency.medium(size: 12).render(target: accountSymbol)
		progressView.setProgress(progress: .random(in: 0.3..<1))
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


class AccountCardCollectionCell: ConfigurableCollectionCell {
	
	private lazy var view: AccountCardView = { .init() }()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		contentView.addSubview(view)
		contentView.setFittingConstraints(childView: view, insets: .zero)
		backgroundColor = .surfaceBackground
	}
	
	func configure(with model: AccountCellModel) {
		view.configureView(account: model.account)
	}
	
}
