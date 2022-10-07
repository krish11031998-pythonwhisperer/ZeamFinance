//
//  ProfileAssets.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 07/10/2022.
//

import Foundation
import UIKit

class ProfileAsset: UIView {
	
	private lazy var imgView: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFit
		return view
	}()
	
	private lazy var balanceLabel: UILabel = { .init() }()
	
	//MARK: - Overriden Methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	override func draw(_ rect: CGRect) {
		let path = UIBezierPath(roundedRect: .init(origin: .init(x: 11, y: 0), size: .init(width: rect.width - 11, height: rect.height)),
								cornerRadius: 16)
		let shape = CAShapeLayer()
		shape.path = path.cgPath
		shape.fillColor = (userInterface == .light ? UIColor.popWhite100 : UIColor.popBlack200).cgColor
		layer.insertSublayer(shape, at: 0)
	}
	
	//MARK: - Protected Methods
	private func setupView() {
		let stack: UIStackView = .HStack(subViews: [imgView, balanceLabel], spacing: 4, alignment: .center)
		balanceLabel.textAlignment = .left
		stack.setFittingConstraints(childView: imgView, top: 0, bottom: 0, width: 22)
		addSubview(stack)
		setFittingConstraints(childView: stack, insets: .init(top: 0, left: 0, bottom: 0, right: 10))
	}
	
	//MARK: - Exposed Methods
	public func configureView(img image: UIImage, text: String) {
		imgView.image = image.resized(size: .init(squared: 22))
		text.bold(size: 13).render(target: balanceLabel)
	}
	
}
