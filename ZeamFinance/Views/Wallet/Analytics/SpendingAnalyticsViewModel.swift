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

class SpendingAnalyticsViewModel {
	
	public var view: AnyTableView?
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
	
	//MARK: - Sections
	private var weeklySpendingChartSection: TableSection {
		.init(rows: [TableRow<CustomTableCell>(.init(view: weeklySpendingChart, inset: .init(by: 10), height: 250))], title: "Weekly Chart")
	}
	
	//MARK: - TableViewDataSource
	private func buildDataSource() -> TableViewDataSource {
		.init(sections: [weeklySpendingChartSection])
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
