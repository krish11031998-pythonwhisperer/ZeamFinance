//
//  PaymentModal.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

class PaymentModal: UIViewController {
	
	private lazy var paymentCard: PaymentCard = { .init() }()
	private var model: PaymentCardModel? { PaymentStorage.selectedPayment }
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	private func setupView() {
		if let validPayment = model {
			paymentCard.configureCard(model: validPayment, isPaymentModal: true)
		}
		view.addSubview(paymentCard)
		view.setFittingConstraints(childView: paymentCard, insets: .init(by: 15))
		view.cornerRadius(16, corners: .top)
		view.clipsToBounds = true
		view.backgroundColor = model?.type.color ?? .surfaceBackground
	}
}
