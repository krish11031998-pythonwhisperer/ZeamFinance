//
//  ButtonViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 04/10/2022.
//

import Foundation
import UIKit


fileprivate extension CustomButtonType {
	
	var typeText: String {
		switch self {
		case .default:
			return "Default Button Type"
		case .slender:
			return "Slender Button Type"
		case .stroke(_,_,_,_):
			return "Stroked Button Type"
		}
	}
	
	var backgroundColor: UIColor {
		switch self {
		case .stroke(_,_,_,_):
			return .surfaceBackground
		default:
			return .surfaceBackgroundInverse
		}
	}
	
	var textColor: UIColor {
		switch self {
		case .stroke(_,_,_,_):
			return .textColor
		default:
			return .textColorInverse
		}
	}
	
	static var buttons: [Self] {
		[CustomButtonType.default,
		 CustomButtonType.slender,
		 CustomButtonType.stroke(height: CustomButtonType.default.height)]
	}
}

class ButtonViewController: UIViewController {
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .grouped)
		tableView.separatorStyle = .none
		tableView.backgroundColor = .surfaceBackground
		return tableView
	}()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		standardNavBar()
	}
	
	
	//MARK: - Protected Methods
	
	private func setupViews() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.reloadData(buildDatasource())
	}
	
	private func buttonBuilder(_ type: CustomButtonType = .default, isEnabled: Bool = true) -> UIView {
		let buttonType = "Button Type : \(!isEnabled ? "Disabled Button" : type.typeText)".medium(size: 18).generateLabel
		let buttonDescription = "This is a simple Button ".regular(size: 15).generateLabel
		
		let button = CustomButton()
		button.configureButton(.init(title: "button".bold(color: type.textColor, size: 13),
									 trailingImg: .init(img: .SystemCatalogue.buttonRightArrow.image.withTintColor(!isEnabled ? .popWhite500 : type.textColor, renderingMode: .alwaysOriginal)),
									 backgroundColor: type.backgroundColor,
									 buttonType: type,
									 buttonStyling: .init(cornerRadius: 0)) {
			print("(DEBUG) clicked on \(type.typeText)")
		})
		button.isEnabled = isEnabled
		let stack = UIStackView.VStack(subViews: [buttonType, buttonDescription, button], spacing: 12, alignment: .leading)
		return stack
	}
	
	private var buttonSection: TableSection {
		let differentTypes = CustomButtonType.buttons.compactMap { TableRow<CustomTableCell>(.init(view:  buttonBuilder($0) , inset: .init(by: 8))) }
		let button = buttonBuilder(isEnabled: false)
		let disabled = TableRow<CustomTableCell>(.init(view: button, inset: .init(by: 8)))
		return .init(rows: differentTypes + [disabled])
	}
	
	func buildDatasource() -> TableViewDataSource {
		.init(sections: [buttonSection])
	}
	
}
