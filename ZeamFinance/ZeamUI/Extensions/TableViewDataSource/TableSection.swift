//
//  TableSection.swift
//  SignalMVP
//
//  Created by Krishna Venkatramani on 21/09/2022.
//

import Foundation
import UIKit

//
public struct TableSection {
	let rows:[TableCellProvider]
	let customHeader: UIView?
	let customFooter: UIView?
	let title: String?
	
	init(rows: [TableCellProvider], customHeader: UIView? = nil, customFooter: UIView? = nil, title: String? = nil) {
		self.rows = rows
		self.customHeader = customHeader
		self.customFooter = customFooter
		self.title = title
	}
}
