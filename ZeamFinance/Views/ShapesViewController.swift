//
//  Shapes.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 05/10/2022.
//

import Foundation
import UIKit

class ShapesViewController: UIViewController {
	
	private lazy var tableView: UITableView = {
		let tableView: UITableView = .init(frame: .zero, style: .grouped)
		tableView.backgroundColor = .surfaceBackground
		tableView.separatorStyle = .none
		return tableView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	private func setupViews() {
		view.backgroundColor = .surfaceBackground
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.reloadData(buildDataSource())
		standardNavBar(title: "Shapes")
	}
	
	
	private var curratedShapeLayer: TableSection {
		let colors: [UIView] = [UIColor.yoyo800, UIColor.manna800].compactMap { color in
			let view = UIView(frame: .init(origin: .zero, size: .init(width: 95, height: 85)))
			view.layer.addCuratedCornerShape(color: color)
			view.setFrame(.init(width: 95, height: 85))
			return view
		}
		let stack = UIStackView.HStack(subViews: colors + [.spacer()], spacing: 12)
		return .init(rows: [TableRow<CustomTableCell>(.init(view: stack, inset: .init(vertical: 8, horizontal: 16)))], title: "Curated Shapes")
	}
	
	
	private var boosterShapeLayer: TableSection {
		let coloredViews: [UIView] = [UIColor.yoyo400, UIColor.manna400].compactMap { color in
			let imgView: UIImageView = {
				let view = UIImageView()
				view.setFrame(.init(squared: 115))
				view.backgroundColor = .surfaceBackgroundInverse
				view.cornerFrame = .init(origin: .zero, size: .init(squared: 115))
				return view
			}()
			let titleLabel = "Sleepy Owl Coffee".semiBold(size: 14).generateLabel
			let subTitle = "3 days".medium(size: 14).generateLabel
			let view = UIStackView.VStack(subViews: [imgView, titleLabel, subTitle], spacing: 15).embedInView(insets: .init(by: 20))
			view.frame = .init(origin: .zero, size: .init(width: 155, height: 225))
			view.layer.addboosterShape(curvePoint: CGFloat(115).half + 20, borderColor: color)
			view.setFrame(.init(width: 155, height: 225))
			return view
		}
		let mainStack = UIStackView.HStack(subViews: coloredViews + [.spacer()], spacing: 12)
		return .init(rows: [TableRow<CustomTableCell>(.init(view: mainStack, inset: .init(vertical: 8, horizontal: 16)))], title: "Booster Shapes")
	}
	
	private var sphericalShape: TableSection {
		let bars: [Int] = [250, 450, 750]
		let stack = UIStackView.HStack(subViews: [.spacer()], spacing: 12)
		bars.compactMap { val in
			let progressBar = SphericalProgressBars(frame: CGSize(squared: 100).frame, lineWidth: 7.5)
			progressBar.setFrame(.init(squared: 100))
			progressBar.configureView(val)
			return progressBar
		}.forEach(stack.addArrangedSubview(_:))
		stack.addArrangedSubview(.spacer())
		return .init(rows: [TableRow<CustomTableCell>(.init(view: stack, inset: .init(vertical: 5, horizontal: 8)))], title: "Credit Scores")
	}
	
	private func buildDataSource() -> TableViewDataSource{
		.init(sections: [curratedShapeLayer, boosterShapeLayer, sphericalShape])
	}
	
}
