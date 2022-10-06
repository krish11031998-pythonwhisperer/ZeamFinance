//
//  SymbolImage.swift
//  SignalMVP
//
//  Created by Krishna Venkatramani on 27/09/2022.
//

import Foundation
import UIKit

class SymbolImage: UIView {
	
	private lazy var image: UIImageView = {
		let imgView = UIImageView()
		imgView.clipsToBounds = true
		imgView.backgroundColor = .gray
		return imgView
	}()
	private lazy var stack: UIStackView = { .init() }()
	private lazy var symbolName: UILabel = { .init() }()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func setupView() {
		stack = .HStack(subViews:[image, symbolName], spacing: 8, alignment: .center)
		addSubview(stack)
		setFittingConstraints(childView: stack, insets: .zero)
		symbolName.isHidden = true
	}
	
	
	public func configureView(symbol: String,
							  imgSize: CGSize = .smallestSquare,
							  label: RenderableText? = nil,
							  axis: NSLayoutConstraint.Axis = .horizontal) {
		
		image.setFrame(imgSize)
		image.cornerRadius = min(imgSize.width, imgSize.height).half
		stack.axis = axis
		if let validLabel = label {
			validLabel.render(target: symbolName)
			symbolName.isHidden = false
		}
		
	}
	
}
