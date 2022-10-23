//
//  UITableView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 11/10/2022.
//

import Foundation
import UIKit

extension UITableView {
    
    var headerView: UIView? {
        get { tableHeaderView }
        set {
            guard let header = newValue else { return }
            tableHeaderView = header
            tableHeaderView?.frame = .init(origin: .zero, size: .init(width: .totalWidth, height: header.compressedSize.height))
        }
    }
    
}
