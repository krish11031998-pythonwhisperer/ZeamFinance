//
//  CustomButton.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 04/10/2022.
//

import Foundation
import UIKit


//MARK: - CustomButton
class CustomButton: UIButton {
	
	private lazy var buttonText: UILabel = { .init() }()
	private lazy var leadingImage: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFit
		return view
	}()
	private lazy var trailingImage: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFit
		return view
	}()
	private var mainStack: UIStackView = { .init() }()
	private var action: Callback?
	private var bgColor: UIColor = .clear
	private var textColor: UIColor = .clear
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupViews()
	}
	
	
	override var isEnabled: Bool {
		didSet {
			if !isEnabled {
				backgroundColor = .popBlack100
				buttonText.textColor = .popWhite500
			} else {
				backgroundColor = bgColor
				buttonText.textColor = textColor
			}
		}
	}
	
	//Protected Methods
	private func setupViews() {
		mainStack = .HStack(subViews: [leadingImage, buttonText, trailingImage],spacing: 12, alignment: .center)
		leadingImage.isHidden = true
		trailingImage.isHidden = true
		addSubview(mainStack)
		addAction(.init(handler: handleTap(_:)), for: .touchUpInside)
	}
	
	private func handleTap(_ action: UIAction) {
		layer.animate(animation: .bouncy())
		self.action?()
	}
	
	public func configureButton(_ config: CustomButtonConfig) {
		config.title.render(target: buttonText)
		leadingImage.configureImageView(config.leadingImg)
		trailingImage.configureImageView(config.trailingImg)
		mainStack.isUserInteractionEnabled = false
		backgroundColor = config.backgroundColor
		bgColor = config.backgroundColor
		textColor = buttonText.textColor
		border(color: config.buttonStyling.borderColor,
			   borderWidth: config.buttonStyling.cornerRadius,
			   cornerRadius: config.buttonStyling.cornerRadius)
		clipsToBounds = true
		
		setFittingConstraints(childView: mainStack, insets: config.buttonType.inset)
		setHeight(height: config.buttonType.height, priority: .required)
		border(color: config.buttonType.borderColor, borderWidth: config.buttonType.borderWidth)
		action = config.action
	}
	
}
