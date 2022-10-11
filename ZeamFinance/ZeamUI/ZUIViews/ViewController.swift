//
//  ViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 04/10/2022.
//

import UIKit

class ViewController: UIViewController {

	
	private lazy var tableView: UITableView = {
		let tableView: UITableView = .init(frame: .zero, style: .grouped)
		tableView.separatorStyle = .none
		tableView.backgroundColor = .surfaceBackground
		tableView.showsVerticalScrollIndicator = false
		return tableView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		view.backgroundColor = .surfaceBackground
		setupViews()
	}
	
	//MARK: - Protected Methods
	
	private func setupViews() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.reloadData(buildDatasource())
	}
	
	private func componentNameView(_ name:String) -> UIView {
		return name.regular(size: 15).generateLabel
	}
	
	private func buildDatasource() -> TableViewDataSource{
		.init(sections: [.init(rows: ["Buttons","Offer Components", "Shapes", "Transactions", "Profile"].compactMap { type in
			let view = componentNameView(type)
			let inset: UIEdgeInsets = .init(vertical: 12, horizontal: 16)
			return TableRow<CustomTableCell>(.init(view: view, inset: inset, action: { self.clickedOn(type) }))
		})])
	}
	
	func clickedOn(_ type: String) {
		switch type {
		case "Buttons":
			navigationController?.pushViewController(ButtonViewController(), animated: true)
		case "Offer Components":
			navigationController?.pushViewController(OffersViewController(), animated: true)
		case "Shapes":
			navigationController?.pushViewController(ShapesViewController(), animated: true)
		case "Transactions":
			navigationController?.pushViewController(TransactionViewController(), animated: true)
		case "Profile":
			navigationController?.pushViewController(ProfileViewController(), animated: true)
		default: break;
		}
	}

}

