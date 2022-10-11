//
//  UIViewController.swift
//  SignalMVP
//
//  Created by Krishna Venkatramani on 24/09/2022.
//

import Foundation
import UIKit

protocol AnyTableView: AnyObject {
	func setupHeaderView(view: UIView)
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource)
	func refreshTableView()
}

extension AnyTableView {
	func setupHeaderView(view: UIView) { }
	func refreshTableView() { }
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
	
	func mainPageNavBar(title: String? = nil,
						rightBarButton: UIBarButtonItem? = nil,
						isTransparent: Bool = true)
	{
		if let titleView = title?.sectionHeader(size: 30).generateLabel {
			navigationItem.leftBarButtonItem = .init(customView: titleView)
		}
		setupTransparentNavBar(color: .surfaceBackground, scrollColor: .surfaceBackground)
		navigationItem.rightBarButtonItem = rightBarButton
	}

	func withNavigationController() -> UINavigationController {
		guard let navVC = self as? UINavigationController else { return .init(rootViewController: self) }
		return navVC
	}
	
	@objc
	func navigateTo(_ to: UIViewController) {
		navigationController?.pushViewController(to, animated: true)
	}
	
	var topMost: UIViewController? {
		switch self {
		case let navigation as UINavigationController:
			return navigation.visibleViewController?.topMost
		case let presented where presentedViewController != nil:
			return presented.presentedViewController?.topMost
		case let tabbar as UITabBarController:
			return tabbar.selectedViewController?.topMost
		default:
			return self
		}
	}
}


//MARK: - Presentation Extension

extension UIViewController {
	
	
	func presentCard(controller vc: UIViewController, withNavigation: Bool, onDismissal: Callback?) {

		if let currentCard = presentedViewController {
			currentCard.dismiss(animated: true) {
				DispatchQueue.main.async {
					self.presentCard(controller: vc, withNavigation: withNavigation, onDismissal: onDismissal)
				}
			}
		} else {
			let target = vc.withNavigationController()
			let presenter = PresentationViewController(presentedViewController: target, presenting: self, onDismissal: onDismissal)
			target.transitioningDelegate = presenter
			target.modalPresentationStyle = .custom
			present(target, animated: true)
		}
	}
	
}
