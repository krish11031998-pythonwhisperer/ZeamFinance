//
//  CustomTableCell.swift
//  SignalMVP
//
//  Created by Krishna Venkatramani on 04/10/2022.
//

import Foundation
import UIKit

struct CustomTableCellModel: ActionProvider {
	let view: UIView
	let inset: UIEdgeInsets
	var action: Callback?
}


class CustomTableCell: ConfigurableCell {
	
	func configure(with model: CustomTableCellModel) {
		contentView.removeChildViews()
		selectionStyle = .none
		backgroundColor = .surfaceBackground
		contentView.addSubview(model.view)
		contentView.setFittingConstraints(childView: model.view, insets: model.inset)
	}
	
}
