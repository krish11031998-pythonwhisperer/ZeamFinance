//
//  ColorBuilder.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 04/10/2022.
//

import Foundation
import UIKit

public protocol ColorGenerator {
	var color: UIColor { get }
}

public extension UIColor {
	
	//MARK: - appColors
	enum AppColors: String {
		
		//Manna
		case manna100
		case manna200
		case manna300
		case manna400
		case manna500
		case manna600
		case manna700
		case manna800
		case manna900
		
		//neoPacha
		case neoPacha100
		case neoPacha200
		case neoPacha300
		case neoPacha400
		case neoPacha500
		case neoPacha600
		case neoPacha700
		case neoPacha800
		case neoPacha900
		
		//orangeSunshine
		case orangeSunshine100
		case orangeSunshine200
		case orangeSunshine300
		case orangeSunshine400
		case orangeSunshine500
		case orangeSunshine600
		case orangeSunshine700
		case orangeSunshine800
		case orangeSunshine900
		
		//parkGreen
		case parkGreen100
		case parkGreen200
		case parkGreen300
		case parkGreen400
		case parkGreen500
		case parkGreen600
		case parkGreen700
		case parkGreen800
		case parkGreen900
		
		//pinkPong
		case pinkPong100
		case pinkPong200
		case pinkPong300
		case pinkPong400
		case pinkPong500
		case pinkPong600
		case pinkPong700
		case pinkPong800
		case pinkPong900
		
		//poliPurple
		case poliPurple100
		case poliPurple200
		case poliPurple300
		case poliPurple400
		case poliPurple500
		case poliPurple600
		case poliPurple700
		case poliPurple800
		case poliPurple900
		
		//yoyo
		case yoyo100
		case yoyo200
		case yoyo300
		case yoyo400
		case yoyo500
		case yoyo600
		case yoyo700
		case yoyo800
		
	}
	
	//AppColor
	static var manna100 : UIColor { AppColors.manna100.color }
	static var manna200 : UIColor { AppColors.manna200.color }
	static var manna300 : UIColor { AppColors.manna300.color }
	static var manna400 : UIColor { AppColors.manna400.color }
	static var manna500 : UIColor { AppColors.manna500.color }
	static var manna600 : UIColor { AppColors.manna600.color }
	static var manna700 : UIColor { AppColors.manna700.color }
	static var manna800 : UIColor { AppColors.manna800.color }
	static var manna900 : UIColor { AppColors.manna900.color }
	static var neoPacha100 : UIColor { AppColors.neoPacha100.color }
	static var neoPacha200 : UIColor { AppColors.neoPacha200.color }
	static var neoPacha300 : UIColor { AppColors.neoPacha300.color }
	static var neoPacha400 : UIColor { AppColors.neoPacha400.color }
	static var neoPacha500 : UIColor { AppColors.neoPacha500.color }
	static var neoPacha600 : UIColor { AppColors.neoPacha600.color }
	static var neoPacha700 : UIColor { AppColors.neoPacha700.color }
	static var neoPacha800 : UIColor { AppColors.neoPacha800.color }
	static var neoPacha900 : UIColor { AppColors.neoPacha900.color }
	static var orangeSunshine100 : UIColor { AppColors.orangeSunshine100.color }
	static var orangeSunshine200 : UIColor { AppColors.orangeSunshine200.color }
	static var orangeSunshine300 : UIColor { AppColors.orangeSunshine300.color }
	static var orangeSunshine400 : UIColor { AppColors.orangeSunshine400.color }
	static var orangeSunshine500 : UIColor { AppColors.orangeSunshine500.color }
	static var orangeSunshine600 : UIColor { AppColors.orangeSunshine600.color }
	static var orangeSunshine700 : UIColor { AppColors.orangeSunshine700.color }
	static var orangeSunshine800 : UIColor { AppColors.orangeSunshine800.color }
	static var orangeSunshine900 : UIColor { AppColors.orangeSunshine900.color }
	static var parkGreen100 : UIColor { AppColors.parkGreen100.color }
	static var parkGreen200 : UIColor { AppColors.parkGreen200.color }
	static var parkGreen300 : UIColor { AppColors.parkGreen300.color }
	static var parkGreen400 : UIColor { AppColors.parkGreen400.color }
	static var parkGreen500 : UIColor { AppColors.parkGreen500.color }
	static var parkGreen600 : UIColor { AppColors.parkGreen600.color }
	static var parkGreen700 : UIColor { AppColors.parkGreen700.color }
	static var parkGreen800 : UIColor { AppColors.parkGreen800.color }
	static var parkGreen900 : UIColor { AppColors.parkGreen900.color }
	static var pinkPong100 : UIColor { AppColors.pinkPong100.color }
	static var pinkPong200 : UIColor { AppColors.pinkPong200.color }
	static var pinkPong300 : UIColor { AppColors.pinkPong300.color }
	static var pinkPong400 : UIColor { AppColors.pinkPong400.color }
	static var pinkPong500 : UIColor { AppColors.pinkPong500.color }
	static var pinkPong600 : UIColor { AppColors.pinkPong600.color }
	static var pinkPong700 : UIColor { AppColors.pinkPong700.color }
	static var pinkPong800 : UIColor { AppColors.pinkPong800.color }
	static var pinkPong900 : UIColor { AppColors.pinkPong900.color }
	static var poliPurple100 : UIColor { AppColors.poliPurple100.color }
	static var poliPurple200 : UIColor { AppColors.poliPurple200.color }
	static var poliPurple300 : UIColor { AppColors.poliPurple300.color }
	static var poliPurple400 : UIColor { AppColors.poliPurple400.color }
	static var poliPurple500 : UIColor { AppColors.poliPurple500.color }
	static var poliPurple600 : UIColor { AppColors.poliPurple600.color }
	static var poliPurple700 : UIColor { AppColors.poliPurple700.color }
	static var poliPurple800 : UIColor { AppColors.poliPurple800.color }
	static var poliPurple900 : UIColor { AppColors.poliPurple900.color }
	static var yoyo100 : UIColor { AppColors.yoyo100.color }
	static var yoyo200 : UIColor { AppColors.yoyo200.color }
	static var yoyo300 : UIColor { AppColors.yoyo300.color }
	static var yoyo400 : UIColor { AppColors.yoyo400.color }
	static var yoyo500 : UIColor { AppColors.yoyo500.color }
	static var yoyo600 : UIColor { AppColors.yoyo600.color }
	static var yoyo700 : UIColor { AppColors.yoyo700.color }
	static var yoyo800 : UIColor { AppColors.yoyo800.color }
	
	static func appColor(appColor: AppColors) -> UIColor {
		.init(named: appColor.rawValue) ?? .black
	}
	
	//MARK: - BaseColor
	
	enum BaseColors: String {
		//popBlack
		case popBlack100
		case popBlack200
		case popBlack300
		case popBlack400
		case popBlack500
		
		//popWhite
		case popWhite100
		case popWhite200
		case popWhite300
		case popWhite400
		case popWhite500
	}
	
	static var popBlack100 : UIColor { BaseColors.popBlack100.color }
	static var popBlack200 : UIColor { BaseColors.popBlack200.color }
	static var popBlack300 : UIColor { BaseColors.popBlack300.color }
	static var popBlack400 : UIColor { BaseColors.popBlack400.color }
	static var popBlack500 : UIColor { BaseColors.popBlack500.color }
	static var popWhite100 : UIColor { BaseColors.popWhite100.color }
	static var popWhite200 : UIColor { BaseColors.popWhite200.color }
	static var popWhite300 : UIColor { BaseColors.popWhite300.color }
	static var popWhite400 : UIColor { BaseColors.popWhite400.color }
	static var popWhite500 : UIColor { BaseColors.popWhite500.color }
	
	
	//MARK: - Semantic Colors
	enum SemanticColors: String {
		
		//error
		case error100
		case error200
		case error300
		case error400
		case error500
		
		//info
		case info100
		case info200
		case info300
		case info400
		case info500
		
		//success
		case success100
		case success200
		case success300
		case success400
		case success500
		
		//warning
		case warning100
		case warning200
		case warning300
		case warning400
		case warning500
	}
	
	static var error100 : UIColor { SemanticColors.error100.color }
	static var error200 : UIColor { SemanticColors.error200.color }
	static var error300 : UIColor { SemanticColors.error300.color }
	static var error400 : UIColor { SemanticColors.error400.color }
	static var error500 : UIColor { SemanticColors.error500.color }
	static var info100 : UIColor { SemanticColors.info100.color }
	static var info200 : UIColor { SemanticColors.info200.color }
	static var info300 : UIColor { SemanticColors.info300.color }
	static var info400 : UIColor { SemanticColors.info400.color }
	static var info500 : UIColor { SemanticColors.info500.color }
	static var success100 : UIColor { SemanticColors.success100.color }
	static var success200 : UIColor { SemanticColors.success200.color }
	static var success300 : UIColor { SemanticColors.success300.color }
	static var success400 : UIColor { SemanticColors.success400.color }
	static var success500 : UIColor { SemanticColors.success500.color }
	static var warning100 : UIColor { SemanticColors.warning100.color }
	static var warning200 : UIColor { SemanticColors.warning200.color }
	static var warning300 : UIColor { SemanticColors.warning300.color }
	static var warning400 : UIColor { SemanticColors.warning400.color }
	static var warning500 : UIColor { SemanticColors.warning500.color }
		
	//MARK: - SystemColor
	enum SystemColor: String {
		case surfaceBackground
		case surfaceBackgroundInverse
		case textColor
		case textColorInverse
	}
	
	static var surfaceBackground : UIColor  { SystemColor.surfaceBackground.color }
	static var surfaceBackgroundInverse : UIColor  { SystemColor.surfaceBackgroundInverse.color }
	static var textColor : UIColor  { SystemColor.textColor.color }
	static var textColorInverse : UIColor  { SystemColor.textColorInverse.color }
	
}

public extension UIColor.BaseColors {
	var color: UIColor { .init(named: rawValue) ?? .black }
}

public extension UIColor.AppColors {
	var color: UIColor { .init(named: rawValue) ?? .red }
}

public extension UIColor.SemanticColors {
	var color: UIColor { .init(named: rawValue) ?? .black }
}

public extension UIColor.SystemColor {
	var color: UIColor { .init(named: rawValue) ?? .black }
}

