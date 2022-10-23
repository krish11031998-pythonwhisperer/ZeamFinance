//
//  SpendingAnalyticsViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 16/10/2022.
//

import Foundation
import UIKit

//MARK: - Definations
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

//MARK: - SplitModel
struct SpendingSplitModel {
	let name: String
	let color: UIColor
	let value: CGFloat
}

//MARK: - SpendingSplitModel Comparable

extension SpendingSplitModel: Comparable {
	static func < (lhs: SpendingSplitModel, rhs: SpendingSplitModel) -> Bool {
		lhs.value < rhs.value
	}
}

//MARK: - SpendingSplitModel View

extension SpendingSplitModel {
	
	var view: UIView {
		let typeIndicator: UIView = .init()
		typeIndicator.circleFrame = .init(origin: .zero, size: .init(squared: 10))
		typeIndicator.backgroundColor = color
		typeIndicator.setFrame(.init(squared: 10))
		let valueLabel = DualLabel()
		valueLabel.configureLabel(title: name.medium(size: 12),
								  subTitle: String(format: "$ %.2f", value).bold(size: 14),
								  config: .init(axis: .horizontal, subTitleTextAlignment: .right, spacing: 30))
		return .HStack(subViews: [typeIndicator, valueLabel], spacing: 8, alignment: .center)
	}
	
}

//MARK: - SpendingAnalyticsViewModel

class SpendingAnalyticsViewModel {
	
	public weak var view: AnyTableView?
	private var binding: [Events:Callback?] = [:]
	private var spendingSplit: [SpendingSplitModel] = []

	public func loadData() {
		spendingSplit = [.init(name: "Rent", color: .orangeSunshine500, value: .random(in: 300..<500)),
						 .init(name: "Entertainment", color: .yoyo500, value: .random(in: 100..<200)),
						 .init(name: "Expenses", color: .neoPacha500, value: .random(in: 200..<400))]
		view?.reloadTableWithDataSource(buildDataSource())
        view?.setupHeaderView(view: budgetSplitView)
	}
	
	//MARK: - Computed Properties
	

	//MARK: - Views
    
    private var budgetSplitView: UIView {
        let view = SpendingAnalyticsBudgetView(frame: .init(origin: .zero, size: .init(width: .totalWidth, height: 200)))
        view.configureView()
        view.setFrame(width: .totalWidth, height: 200)
        return view.embedInView(insets: .init(vertical: 25, horizontal: 0), priority: .needed)
    }
    
	private var weeklySpendingChart: UIView {
		let view = WeeklyChartView(frame: .init(origin: .zero, size: .init(width: .totalWidth, height: 250)))
		view.configureChart(.init(daily: Array(repeating: TransactionDailyModel(txns: Array(repeating: TransactionModel(detail: "Sample"),
																							count: Int.random(in: 10..<100))) , count: 7)))
		return view
	}
	
	private var spendingSplitChart: UIView {
		let total = spendingSplit.map(\.value).reduce(0, +)
		let sortedSpending = spendingSplit.sorted(by: { $0 < $1 })
		var chartModel: [MultipleStrokeCircularProgressBarModel] = []
		let angles:[CGFloat] = sortedSpending.map {$0.value/total}.additiveValue.map { ($0 - 1) * 180 }
		for (spendingData, ratio) in zip(sortedSpending, angles) {
			let data: MultipleStrokeCircularProgressBarModel = .init(color: spendingData.color, end: ratio)
			if chartModel.isEmpty {
				chartModel = [data]
			} else {
				chartModel.insert(data, at: 0)
			}
		}
		
		let view = MultipleStrokeCircularProgressBar(start: -180,
													 end: 0,
													 frame: .init(origin: .zero, size: .init(width: 120, height: 60)),
													 strokeWidth: 10,
													 radiusOffset: -10,
													 clockwise: true,
													 isSemiCircle: true)
		view.setupChart(model: chartModel)
		view.setWidth(width: 120, priority: .required)
		return view
	}
	
	private var spendingSplitView: UIView {
		let spendingStack = UIStackView.VStack(subViews: spendingSplit.map(\.view) + [.spacer()], spacing: 10)
		let stack = UIStackView.HStack(subViews: [spendingSplitChart,.spacer(), spendingStack], spacing: 10)
		return stack
	}
	
	//MARK: - Sections
	private var weeklySpendingChartSection: TableSection {
		.init(rows: [TableRow<CustomTableCell>(.init(view: weeklySpendingChart, inset: .init(by: 10), height: 250))], title: "Weekly Chart")
	}
	
	private var spendingSplitSection: TableSection {
		let view = spendingSplitView.embedIntoCard(spendingSplitView.userInterface == .light ? .popWhite300 : .popBlack300, inset: .init(by: 16))
		return .init(rows: [TableRow<CustomTableCell>(.init(view: view, inset: .init(vertical: 0, horizontal: 10)))], title: "Spending Indicator")
	}
    
    private var spendingSplitBreakdown: TableSection {
        let rowCells: [TableCellProvider] = [1,2,3].map { _ in
            return TableRow<ExperimentTableCell>(.init(action: {
                print("(DEBUG) Clicked!")
            }))
        }
        return .init(rows: rowCells)
    }
	
	//MARK: - TableViewDataSource
	private func buildDataSource() -> TableViewDataSource {
		.init(sections: [weeklySpendingChartSection, spendingSplitSection, spendingSplitBreakdown])
//        .init(sections: [spendingSplitBreakdown])
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


//MARK: - ExperimentView

class ExperimentView: UIView {
    
    private lazy var label: UILabel = { .init() }()
    private lazy var progressBar: ProgressBar = { .init() }()
    private lazy var dualLabel: DualLabel = { .init() }()
    private lazy var viewStack: UIStackView = {
        .VStack(subViews: [dualLabel, progressBar], spacing: 10)
    }()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        dualLabel.configureLabel(title: "Rent".medium(size: 15), subTitle: String(format: "$ %.2f", Float.random(in: 100..<1000)).regular(size: 15), config: .init(alignment: .center, axis: .horizontal))
        viewStack.insertArrangedSubview(.spacer(), at: 1)
        let container = viewStack.embedInView(insets: .init(by: 17.5))
        container.addBlurView()
        container.clippedCornerRadius = 12
        addSubview(container)
        setFittingConstraints(childView: container, insets: .init(vertical: 2.5, horizontal: 10))
        progressBar.setHeight(height: 12)
//        label.setHeight(height: 20)
        setHeight(height: compressedSize.height)
    }
    
    func configureView(val: Int) {
        "\(val)".bold(size: 15).render(target: label)
        layer.animate(animation: .slideIn(from: -10, to: 0, show: true, duration: 1)) {
            self.progressBar.setProgress(progress: .random(in: 0.3...1), color: .white)
        }
        
    }
}

//MARK: - ExperimentViewTableCell

class ExperimentTableCell: ConfigurableCell {
    private lazy var view: ExperimentView = {
        .init()
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        contentView.addSubview(view)
        contentView.setFittingConstraints(childView: view, insets: .zero)
        contentView.backgroundColor = .surfaceBackground
    }
    
    func configure(with model: EmptyClickableModel) {
        view.configureView(val: .random(in: 1...10))
    }
    
    
}
