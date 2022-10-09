//
//  QRCodeBuilder.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 09/10/2022.
//

import Foundation
import UIKit
import CoreImage.CIFilterBuiltins
import CoreImage.CIFilter

extension UIImage {
	
	static func generateQRCode(_ dataObj: Codable) -> UIImage? {
		guard let data = try? JSONEncoder().encode(dataObj),
			  let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
		// 4
		qrFilter.setValue(data, forKey: "inputMessage")
		// 5
		guard let qrImage = qrFilter.outputImage else { return nil }
		return .init(ciImage: qrImage)
	}
	
}
