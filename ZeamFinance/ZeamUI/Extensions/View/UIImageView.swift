//
//  UIImageView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 15/10/2022.
//

import Foundation
import UIKit

extension UIImageView {
	
	var aspectRatio : CGFloat {
		guard let validImage = image else { return 0 }
		return validImage.size.width/validImage.size.height
	}
	
	func setupSizeWithRatio(width: CGFloat? = nil,height: CGFloat? = nil) {
		guard width != nil || height != nil else { return }
		if let validWidth = width {
			setFrame(width: validWidth, height: validWidth/aspectRatio)
		}
		if let validHeight = height {
			setFrame(width: aspectRatio * validHeight, height: validHeight)
		}
	}
	
}
