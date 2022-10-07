//
//  MainTabViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 07/10/2022.
//

import Foundation
import UIKit

class MainTabViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .clear
		let tabBar = { () -> MainTabView in
			let tabBar = MainTabView()
			tabBar.delegate = self
			return tabBar
		}()
		self.setValue(tabBar, forKey: "tabBar")
		setupTabs()
		tabBar.tintColor = .white
	}
	
	private func setupTabs() {
		let home = HomeViewController().withNavigationController()
		home.tabBarItem = .init(title: "Home", image: .TabBarImageCatalogue.home.image.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal).resized(size: .init(squared: 24)),
								selectedImage: .TabBarImageCatalogue.homeSelected.image.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal).resized(size: .init(squared: 24)))
		let components = ViewController().withNavigationController()
		components.tabBarItem = .init(title: "ZUI", image: nil, selectedImage: nil)
		setViewControllers([home, components], animated: true)
	}
	
}
