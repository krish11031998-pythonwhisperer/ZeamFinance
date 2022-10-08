//
//  UIViewController.swift
//  SignalMVP
//
//  Created by Krishna Venkatramani on 24/09/2022.
//

import Foundation
import UIKit

protocol AnyTableView {
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource)
}

extension UIViewController {
	
	func setupTransparentNavBar(color: UIColor = .clear, scrollColor: UIColor = .clear) {
		let navbarAppear: UINavigationBarAppearance = .init()
		navbarAppear.configureWithTransparentBackground()
		navbarAppear.backgroundImage = UIImage()
		navbarAppear.backgroundColor = color
		
		self.navigationController?.navigationBar.standardAppearance = navbarAppear
		self.navigationController?.navigationBar.compactAppearance = navbarAppear
		self.navigationController?.navigationBar.scrollEdgeAppearance = navbarAppear
		self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = scrollColor
	}
	
	
	func showNavbar() {
		guard let navController = navigationController else { return }
		if navController.isNavigationBarHidden {
			navController.setNavigationBarHidden(false, animated: true)
		}
	}
	
	func hideNavbar() {
		guard let navController = navigationController else { return }
		if !navController.isNavigationBarHidden {
			navController.setNavigationBarHidden(true, animated: true)
		}
	}
	
	static func backButton(_ target: UIViewController) -> UIBarButtonItem {
		let buttonImg = UIImage.buttonLeftArrow.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal).resized(size: .init(width: 31.5, height: 12))
		let imgView = UIImageView(image: buttonImg)
		imgView.frame = .init(origin: .zero, size: .init(squared: 32))
		imgView.contentMode = .center
		let barItem: UIBarButtonItem = .init(image: imgView.snapshot.withRenderingMode(.alwaysOriginal),
											 style: .plain,
											 target: target,
											 action: #selector(target.popViewController))
		return barItem
	}
	
	@objc
	func popViewController() {
		navigationController?.popViewController(animated: true)
	}
	
	func standardNavBar(title: String? = nil,
						leftBarButton: UIBarButtonItem? = nil,
						rightBarButton: UIBarButtonItem? = nil,
						isTransparent: Bool = true)
	{
		if isTransparent {
			setupTransparentNavBar()
		} else {
			setupTransparentNavBar(color: .surfaceBackground)
		}
		navigationItem.titleView = title?.sectionHeader(size: 20).generateLabel
		navigationItem.leftBarButtonItem = leftBarButton ?? Self.backButton(self)
		navigationItem.rightBarButtonItem = rightBarButton
	}
	
	func withNavigationController() -> UINavigationController {
		.init(rootViewController: self)
	}
	
	@objc
	func navigateTo(_ to: UIViewController) {
		navigationController?.pushViewController(to, animated: true)
	}
}
