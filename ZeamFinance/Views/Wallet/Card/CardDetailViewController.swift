//
//  CardDetailViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 11/10/2022.
//

import Foundation
import UIKit

class CardDetailViewController: UIViewController {
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .grouped)
		tableView.backgroundColor = .surfaceBackground
		tableView.separatorStyle = .none
		return tableView
	}()
	
	private lazy var viewModel: CardDetailViewModel = {
		let model = CardDetailViewModel()
		model.view = self
		return model
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		viewModel.loadData()
	}
	
	private lazy var closeButton: UIButton = {
		let button = UIButton(frame: .init(origin: .zero, size: .init(squared: 25)))
		button.setImage(.init(systemName: "xmark")?.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal), for: .normal)
		button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
		return button
	}()
	
	@objc
	private func closeModal() {
		dismiss(animated: true) {
			CardStorage.selectedCard = nil
		}
	}
	
	private func setupView() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		preferredContentSize = .init(width: .totalWidth, height: .totalHeight)
		standardNavBar(leftBarButton: .init(customView: "Card Detail".sectionHeader(size: 20).generateLabel),
					   rightBarButton: .init(customView: closeButton), isTransparent: false)
	}
}

extension CardDetailViewController: AnyTableView {
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource) {
		tableView.reloadData(dataSource)
	}
}
