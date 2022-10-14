//
//  CardStorage.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 11/10/2022.
//

import Foundation

class CardStorage {
	
	static var selectedCard: CardModel? = nil
	
	static func selectCard(_ card: CardModel) {
		selectedCard = card
		if card != nil {
			NotificationCenter.default.post(name: .showCard, object: nil)
		}
	}
}
