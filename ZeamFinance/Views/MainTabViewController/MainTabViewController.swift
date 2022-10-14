//
//  MainTabViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 07/10/2022.
//

import Foundation
import UIKit

fileprivate extension UITabBarItem {
	convenience init(title: String, image: UIImage.TabBarImageCatalogue, selectedImage: UIImage.TabBarImageCatalogue) {
		self.init(title: title, image: image.image.resized(size: .init(squared: 24)), selectedImage: selectedImage.image.resized(size: .init(squared: 24)))
	}
}

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
		tabBar.tintColor = .surfaceBackgroundInverse
		addObservers()
	}
	
	private func setupTabs() {
		let home = HomeViewController().withNavigationController().tabBarItem(.home)
		let wallet = WalletViewController().withNavigationController().tabBarItem(.wallet)
		let offers = ZeamOfferViewController().withNavigationController().tabBarItem(.offers)
		let pay = PayViewController().withNavigationController().tabBarItem(.pay)
		let profile = ProfileViewController().withNavigationController().tabBarItem(.profile)
		let components = ViewController().withNavigationController().tabBarItem(.none)
		setViewControllers([home, wallet, offers, pay, profile], animated: true)
	}
	
	
	private func addObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(showPaymentCard), name: .showPayment, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(showTransaction), name: .showTxn, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(readQRCode), name: .readQRCode, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(showCardDetail), name: .showCard, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(showAccountDetail), name: .showAccount, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(showAccountsForPayment), name: .showAccounts, object: nil)
	}
	
	@objc
	private func showPaymentCard() {
		presentCard(controller: PaymentModal(), withNavigation: false) {
			PaymentStorage.selectedPayment = nil
		}
	}
	
	@objc
	private func showTransaction() {
		presentCard(controller: WalletTransactionModal(), withNavigation: true) {
			TransactionStorage.selectedTransaction = nil
		}
	}
	
	@objc
	private func readQRCode() {
		presentCard(controller: QRCodeReaderViewController(), withNavigation: true) {
			print("(DEBUG) read QR Code!")
			if PaymentStorage.selectedPayment != nil {
				self.presentCard(controller: PaymentModal(), withNavigation: false) {
					PaymentStorage.selectedPayment = nil
				}
			}
		}
	}
	
	@objc
	private func showCardDetail() {
		topMost?.presentCard(controller: CardDetailViewController(), withNavigation: true) {
			if CardStorage.selectedCard != nil {
				CardStorage.selectedCard = nil
			}
		}
	}
	
	@objc
	private func showAccountDetail() {
		topMost?.presentCard(controller: AccountDetailViewController(), withNavigation: true) {
			print("(DEBUG) Close!")
		}
	}
	
	@objc
	private func showAccountsForPayment() {
		presentCard(controller: AccountModal(), withNavigation: true) {
			AccountStorage.accountsForUser = nil
		}
	}
}
