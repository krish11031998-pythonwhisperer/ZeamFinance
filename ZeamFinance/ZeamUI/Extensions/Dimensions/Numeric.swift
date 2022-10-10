//
//  Numeric.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 10/10/2022.
//

import Foundation
//MARK: - Element:Numeric

extension Array where Element:Numeric{
	
	func square() -> [Self.Element]{
		return map({$0 * $0})
	}
	
	func overallChange() -> Self.Element?{
		guard let safeFirst = self.first,let safeLast = self.last else {return nil}
		return (safeLast - safeFirst)
	}
}
