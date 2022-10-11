//
//  LabelButton.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 10/10/2022.
//

import Foundation
import UIKit

struct LabelButtonConfig{
	let title: RenderableText?
	let img: UIImage
	let addImageBackgound: Bool
	let spacing: CGFloat
	let alignment: UIStackView.Alignment
	let action: Callback?
	
	init(title: RenderableText?, img: UIImage,
		 addImageBackgound: Bool = true,
		 spacing: CGFloat = 10,
		 alignment: UIStackView.Alignment = .center,
		 action: Callback?) {
		self.title = title
		self.img = img
		self.addImageBackgound = addImageBackgound
		self.spacing = spacing
		self.alignment = alignment
		self.action = action
	}
}

class LabelButton: UIView {
	
	private lazy var imageView: UIImageView = {
		let view = UIImageView()
		view.contentMode = .center
		view.clipsToBounds = true
		return view
	}()
	private lazy var stackView: UIStackView = { .VStack(spacing: 0) }()
	private lazy var label: UILabel = { .init() }()
	private var action: Callback?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	private func setupView() {
		[imageView, label].forEach(stackView.addArrangedSubview(_:))
		addSubview(stackView)
		setFittingConstraints(childView: stackView, insets: .zero)
		label.isHidden = true
	}
	
	func setupTapGesture(action: Callback?) {
		guard action != nil else { return }
		self.action = action
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addAction))
		gestureRecognizers?.forEach{removeGestureRecognizer($0)}
		addGestureRecognizer(tapGesture)
	}
	
	@objc
	func addAction() {
		guard let validAction = action else { return }
		validAction()
	}
	
	func configure(model: LabelButtonConfig) {
		stackView.alignment = model.alignment
		stackView.spacing = model.spacing
		imageView.image = model.img
			.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal)
			.resized(size: .init(squared: 16))
		imageView.backgroundColor = .popBlack100
		imageView.circleFrame = .init(origin: .zero, size: .init(squared: 32))
		imageView.setFrame(.init(squared: 32))
		if let validText = model.title {
			validText.render(target: label)
		}
		setupTapGesture(action: model.action)
	}
	
	
}
