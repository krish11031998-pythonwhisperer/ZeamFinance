//
//  PaymentCard.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 07/10/2022.
//

import Foundation
import UIKit

class PaymentCard: UIView {
	
	private lazy var imageView: UIImageView = {
		let view = UIImageView()
		view.contentMode = .center
		view.setFrame(.init(squared: 48))
		view.border(color: .popBlack100.withAlphaComponent(0.2), borderWidth: 1, cornerRadius: 0)
		view.clipsToBounds = true
		return view
	}()
	
	private lazy var billInfo: DualLabel = { .init() }()
	
	private lazy var billDetailStack: UIStackView = {.HStack(subViews:[billInfo, .spacer(), imageView], spacing: 14, alignment: .top)  }()
	
	private lazy var amountLabel: UILabel = { .init() }()
	
	private lazy var payButton: CustomButton = {
		let button = CustomButton()
		button.configureButton(.init(title: "Pay now".bold(color: .popWhite500, size: 12),
									 trailingImg: .init(img: .buttonRightArrow),
									 backgroundColor: .popBlack500, action: showPayment))
		return button
	}()
	
	private lazy var installCounter: UIStackView = { .HStack(spacing: 5, alignment: .center) }()
	
	private lazy var mainStack: UIStackView = { .VStack(spacing: 12) }()
	
	private var model: PaymentCardModel?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func setupView() {
		[billDetailStack, .spacer(), amountLabel, installCounter, payButton].forEach(mainStack.addArrangedSubview(_:))
		mainStack.setFittingConstraints(childView: installCounter, leading: 0, trailing: 0)
		installCounter.isHidden = true
		addSubview(mainStack)
		setFittingConstraints(childView: mainStack, insets: .init(by: 10))
		backgroundColor = .surfaceBackgroundInverse
		clippedCornerRadius = 12
	}
	
	private func setupInstallmentCounter(_ count: Int, total: Int) {
		installCounter.distribution = .fillEqually
		installCounter.removeChildViews()
		let blobWidth = (mainStack.compressedSize.width - installCounter.spacing * CGFloat(total - 1))/CGFloat(total)
		for idx in 0..<total {
			let view = UIView()
			view.setHeight(height: blobWidth, priority: .needed)
			view.backgroundColor = idx < count ? .parkGreen500 : .popBlack100
			view.cornerRadius = blobWidth.half
			installCounter.addArrangedSubview(view)
		}
		installCounter.isHidden = false
	}
	
	public func configureCard(model: PaymentCardModel) {
		imageView.image = model.billCompanyLogo.resized(size: .init(squared: 32))
		billInfo.configureLabel(title: model.billCompany.bold(color: .popBlack500, size: 14),
								subTitle: model.billDescription.medium(color: .popBlack500, size: 12))
		backgroundColor = model.type.color
		imageView.cornerRadius = model.type.imgCornerRadius
		String(format: "AED %.2f", model.amount).bold(color: .popBlack500, size: 18).render(target: amountLabel)
		if model.type == .installment, let count = model.installmentsCount, let total = model.totalInstallments  {
			setupInstallmentCounter(count, total: total)
		}
		self.model = model
	}
	
	private func showPayment() {
		PaymentStorage.selectedPayment = model
		NotificationCenter.default.post(name: .showPayment, object: nil)
	}
	
}

//MARK: - PaymentCardCollectionCell

class PaymentCardCollectionCell: ConfigurableCollectionCell {
	
	private lazy var view: PaymentCard = { .init() }()
	
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
	}
	
	func configure(with model: PaymentCardModel) {
		view.configureCard(model: model)
	}
	
}

//MARK: - PaymentCardTableCell
class PaymentCardTableCell: ConfigurableCell {
	
	private lazy var view: PaymentCard = { .init() }()
	
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
		view.setHeight(height: 200, priority: .required)
		selectionStyle = .none
		backgroundColor = .surfaceBackground
		view.border(cornerRadius: 12)
	}
	
	func configure(with model: PaymentCardModel) {
		view.configureCard(model: model)
	}
	
}
