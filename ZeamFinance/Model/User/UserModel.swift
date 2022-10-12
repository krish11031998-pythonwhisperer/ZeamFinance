//
//  UserModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 12/10/2022.
//

import Foundation
import UIKit

struct UserModel {
	let name: String
	let userName: String
	let userID: String
	let userImg: UIImage?
	let userImgUrl: String?
	
	init(name: String,
		 userName: String,
		 userID: String = UUID().uuidString,
		 userImg: UIImage? = nil,
		 userImgUrl: String? = nil) {
		self.name = name
		self.userName = userName
		self.userID = userID
		self.userImg = userImg
		self.userImgUrl = userImgUrl
	}
}
