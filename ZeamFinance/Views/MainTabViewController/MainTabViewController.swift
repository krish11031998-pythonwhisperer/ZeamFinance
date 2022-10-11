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
		tabBar.tintColor = .surfaceBackgroundInverse
		addObservers()
	}
	
	private func setupTabs() {
		let home = HomeViewController().withNavigationController()
		home.tabBarItem = .init(title: "Home", image: .TabBarImageCatalogue.home.image.resized(size: .init(squared: 24)),
								selectedImage: .TabBarImageCatalogue.homeSelected.image.resized(size: .init(squared: 24)))
		let wallet = WalletViewController().withNavigationController()
		wallet.tabBarItem = .init(title: "Wallet", image: .TabBarImageCatalogue.cards.image.resized(size: .init(squared: 24)),
								  selectedImage: .TabBarImageCatalogue.cardsSelected.image.resized(size: .init(squared: 24)))
		let offers = ZeamOfferViewController().withNavigationController()
		offers.tabBarItem = .init(title: "Offers", image: .TabBarImageCatalogue.shop.image.resized(size: .init(squared: 24)),
								  selectedImage: .TabBarImageCatalogue.shopSelected.image.resized(size: .init(squared: 24)))
		let pay = PayViewController().withNavigationController()
		pay.tabBarItem = .init(title: "Pay", image: .TabBarImageCatalogue.pay.image.resized(size: .init(squared: 24)),
								  selectedImage: .TabBarImageCatalogue.paySelected.image.resized(size: .init(squared: 24)))
		let components = ViewController().withNavigationController()
		components.tabBarItem = .init(title: "ZUI", image: nil, selectedImage: nil)
		setViewControllers([home, wallet, offers, pay, components], animated: true)
	}
	
	
	private func addObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(showPaymentCard), name: .showPayment, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(showTransaction), name: .showTxn, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(readQRCode), name: .readQRCode, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(showCardDetail), name: .showCard, object: nil)
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
	
}
