//
//  ProfileViewControlller.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 06/10/2022.
//

import Foundation
import UIKit

class ZUIProfileViewController: UIViewController {
	
	private lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.separatorStyle = .none
		return table
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		standardNavBar(title: "Profile")
	}
	
	private func setupView() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.backgroundColor = .surfaceBackground
		tableView.reloadData(buildDatasource())
	}
	
	private var profileImageView: TableSection {
		let profileView = ProfileView()
		profileView.configureProfileView(.init(profileImg: .ImageCatalogue.profileImage.image,
											   username: "Krishna",
											   accountNumber: "AE235KJBI234"))
		profileView.setCompressedSize()
		let view = UIView()
		view.addSubview(profileView)
		view.setFittingConstraints(childView: profileView, top: 0, bottom: 0, centerX: 0, priority: .needed)
		return .init(rows: [TableRow<CustomTableCell>(.init(view: view, inset: .zero))], title: "Profile")
	}

	private var creditScoreView: TableSection {
		let creditScoreView = CreditScoreView()
		creditScoreView.configureView(.init(score: 750))
		let view = UIView()
		view.addSubview(creditScoreView)
		view.setFittingConstraints(childView: creditScoreView, top: 0, bottom: 0, width: .totalWidth.half.half * 3, centerX: 0, priority: .needed)
		return .init(rows: [TableRow<CustomTableCell>(.init(view: view, inset: .zero))],
															title: "Credit Card Score")
	}
	
	private var paymentQRCode: TableSection? {
		guard let img = UIImage.generateQRCode(PaymentQRCodeModel(paymentModel: PaymentCardModel.person)) else { return nil }
		let imgView = UIImageView(image: img)
//		imgView.setFrame(.init(squared: 100))
		let view = UIView()
		view.addSubview(imgView)
		view.setFittingConstraints(childView: imgView, top: 0, bottom: 0, width: 100, height: 100, centerX: 0, centerY: 0, priority: .needed)
		return .init(rows: [TableRow<CustomTableCell>(.init(view: view, inset: .zero))], title: "Profile QR Code")
	}
	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [profileImageView, creditScoreView] + [paymentQRCode].compactMap {$0})
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		guard let img = navigationItem.leftBarButtonItem?.image else { return }
		navigationItem.leftBarButtonItem?.image = img.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal)
	}
}
