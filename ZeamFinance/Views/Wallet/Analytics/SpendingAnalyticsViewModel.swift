//
//  SpendingAnalyticsViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 16/10/2022.
//

import Foundation
import UIKit

fileprivate extension TransactionModel {
	
	init(detail: String) {
		self.init(cellLogo: .solid(color: .clear), detail: detail, date: Date.now.formatted(), amount: Float.random(in: 10..<100))
	}
}

fileprivate extension Array where Element: Numeric {
	
	var additiveValue: [Self.Element] {
		guard !isEmpty && count > 1 else { return self }
		var result = self
		for idx in 1..<count {
			result[idx] += result[idx - 1]
		}
		return result
	}
	
}

class SpendingAnalyticsViewModel {
	
	public weak var view: AnyTableView?
	private var binding: [Events:Callback?] = [:]
	
	public func loadData() {
		view?.reloadTableWithDataSource(buildDataSource())
	}
	
	//MARK: - Views
	private var weeklySpendingChart: UIView {
		let view = WeeklyChartView(frame: .init(origin: .zero, size: .init(width: .totalWidth, height: 250)))
		view.configureChart(.init(daily: Array(repeating: TransactionDailyModel(txns: Array(repeating: TransactionModel(detail: "Sample"),
																							count: Int.random(in: 10..<100))) , count: 7)))
		return view
	}
	
	private var spendingSplitChart: UIView {
		let values: [CGFloat] = [0.15, 0.35, 0.5].additiveValue.map { ($0 - 1) * 180 }
		let colors: [UIColor] = [.manna500, .parkGreen500, .yoyo500].reversed()
		let view = MultipleStrokeCircularProgressBar(start: -180,
													 end: 0,
													 frame: .init(origin: .zero, size: .init(squared: 150)),
													 strokeWidth: 10,
													 radiusOffset: -10,
													 clockwise: true)
		var chartModel: [MultipleStrokeCircularProgressBarModel] = []
		for (value, color) in zip(values.sorted(by: { $0 > $1 }), colors) {
			chartModel.append(.init(color: color, end: value))
		}
		view.setupChart(model: chartModel)
		return view
	}
	
	private var spendingSplitView: UIView {
		let stack = UIStackView.HStack(subViews: [spendingSplitChart, .spacer()], spacing: 10)
		return stack
	}
	
	//MARK: - Sections
	private var weeklySpendingChartSection: TableSection {
		.init(rows: [TableRow<CustomTableCell>(.init(view: weeklySpendingChart, inset: .init(by: 10), height: 250))], title: "Weekly Chart")
	}
	
	private var spendingSplitSection: TableSection {
		.init(rows: [TableRow<CustomTableCell>(.init(view: spendingSplitView, inset: .init(by: 10), height: 150))], title: "Spending Indicator")
	}
	
	//MARK: - TableViewDataSource
	private func buildDataSource() -> TableViewDataSource {
		.init(sections: [weeklySpendingChartSection, spendingSplitSection])
	}
}

extension SpendingAnalyticsViewModel {
	public enum Events : String {
		case spending
	}
	
	func callUpdate(_ event: Events) {
		binding[event]??()
	}
	
	func addBinding(_ event: SpendingAnalyticsViewModel.Events, action: Callback?) {
		binding[event] = action
	}
}
