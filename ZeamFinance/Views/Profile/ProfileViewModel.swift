//
//  ProfileViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 12/10/2022.
//

import Foundation
import UIKit

class ProfileViewModel {
	public var view: AnyTableView?
	private var user: UserModel?
	
	public func loadData() {
		user = .init(name: "Krishna", userName: "krish_venkat", userImg: .ImageCatalogue.profileImage.image)
		view?.reloadTableWithDataSource(buildDatasource())
	}
	
	//MARK: - Section
	private var profileImageView: TableSection? {
		guard let validUser = user else { return nil }
		let profileView = ProfileView()
		profileView.configureProfileView(.init(profileImg: .ImageCatalogue.profileImage.image,
											   username: validUser.name,
											   accountNumber: validUser.userName))
		profileView.setCompressedSize()
		let view = UIView()
		view.addSubview(profileView)
		view.setFittingConstraints(childView: profileView, top: 0, bottom: 0, centerX: 0, priority: .needed)
		return .init(rows: [TableRow<CustomTableCell>(.init(view: view, inset: .zero))])
	}
	
	//MARK: - Datasource
	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [profileImageView].compactMap { $0 })
	}
}
