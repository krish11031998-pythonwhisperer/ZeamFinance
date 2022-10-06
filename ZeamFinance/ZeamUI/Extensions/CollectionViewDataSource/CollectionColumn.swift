//
//  CollectionColumn.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 04/10/2022.
//

import Foundation
import UIKit

//MARK: - ConfigurableCollectionCell

typealias ConfigurableCollectionCell = Configurable & UICollectionViewCell

//MARK: - CollectionCellProvider

protocol CollectionCellProvider {
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

//MARK: - CollectionItem
class CollectionItem<Cell:ConfigurableCollectionCell>: CollectionCellProvider {
	var model: Cell.Model
	
	init(_ model: Cell.Model) {
		self.model = model
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: Cell = collectionView.dequeueCell(indexPath: indexPath)
		cell.configure(with: model)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let action = model as? ActionProvider {
			action.action?()
		}
		guard let cell = collectionView.cellForItem(at: indexPath) else { return }
		cell.layer.animate(animation: .bouncy())
	}
}
