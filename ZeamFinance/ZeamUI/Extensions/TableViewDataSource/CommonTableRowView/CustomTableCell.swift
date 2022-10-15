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
	let inset: UIEdgeInsets?
	let top: CGFloat?
	let leading: CGFloat?
	let bottom: CGFloat?
	let trailing: CGFloat?
	let name: String
	var action: Callback?
	
	init(view: UIView,
		 inset: UIEdgeInsets? = nil,
		 top: CGFloat? = nil,
		 leading: CGFloat? = nil,
		 bottom: CGFloat? = nil,
		 trailing: CGFloat? = nil,
		 name:String = "",
		 action: Callback? = nil) {
		self.view = view
		self.inset = inset
		self.top = top
		self.leading = leading
		self.bottom = bottom
		self.trailing = trailing
		self.name = name
		self.action = action
	}
}


class CustomTableCell: ConfigurableCell {
	
	func configure(with model: CustomTableCellModel) {
		contentView.removeChildViews()
		selectionStyle = .none
		backgroundColor = .surfaceBackground
		contentView.addSubview(model.view)
		if let validInset = model.inset {
			contentView.setFittingConstraints(childView: model.view, insets: validInset)
		} else {
			contentView.setFittingConstraints(childView: model.view,
											  top: model.top,
											  leading: model.leading,
											  trailing: model.trailing,
											  bottom: model.bottom)
		}
		
	}
	
}
