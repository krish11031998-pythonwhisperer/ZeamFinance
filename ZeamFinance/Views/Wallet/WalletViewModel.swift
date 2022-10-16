//
//  WalletViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

fileprivate extension TransactionModel {
	
	init(detail: String) {
		self.init(cellLogo: .solid(color: .clear), detail: detail, date: Date.now.formatted(), amount: Float.random(in: 10..<100))
	}
}

class WalletViewModel {
	
	private var cards: [CardModel]?
	private var transactions: [TransactionModel]?
	public weak var view: AnyTableView?
	private var bindings: [Events:Callback?] = [:]
	public func loadData() {
		cards = [.init(bankName: "Emirates NBD", name: "Krishna Venkatramani")]
		transactions = [.init(cellLogo: .IconCatalogue.amazon.image, detail: "amazon", amount: 250),
						.init(cellLogo: .IconCatalogue.netflix.image, detail: "netflix", amount: 50),
						.init(cellLogo: .IconCatalogue.zomato.image, detail: "zomato", amount: 80)]
		view?.reloadTableWithDataSource(buildDatasource())
	}
	
	private func circleChart(_ to: Float) -> UIView {
		GenericCircularProgressBar(frame: .init(origin: .zero, size: .init(squared: 22)),
								   radiusOffset: -1,
								   strokeColor: .parkGreen500,
								   strokeEnd: CGFloat(to),
								   animateStrokeEnd: false)
	}
	
	//MARK: - Views
	private func moreButton(title: RenderableText? = nil, titleString: String? = nil, action: Callback? = nil) -> TableCellProvider  {
		let moreCell = CustomButton()
		moreCell.configureButton(.init(title: titleString?.bold(size: 13) ?? title ?? "",
									   buttonType: .slender,
									   buttonStyling: .init(borderColor: .surfaceBackgroundInverse), action: { [weak self] in
			self?.callUpdate(.showWallet)
		}))
		moreCell.setWidth(width: moreCell.compressedSize.width, priority: .required)
		
		let stack: UIStackView = .HStack(subViews: [moreCell, .spacer()],spacing: 0, alignment: .center)
		return TableRow<CustomTableCell>(.init(view: stack, inset: .init(by: 10)))
	}
	
	public func setupHeaderView() {
		let header = "Balance".sectionHeader(size: 25).generateLabel
		let balance = String(format: "$ %.2f", Float.random(in: 100..<1000)).sectionHeader(size: 35).generateLabel
		let legends = UIStackView.HStack(spacing: 12)
		let accountRatios:[MultipleStrokeModel] = [.init(color: .info500, nameText: "Fiat", val: 0.3),
							 .init(color: .orangeSunshine500, nameText: "BTC", val: 0.2),
							 .init(color: .manna500, nameText: "ZFI", val: 0.5)]
		
		accountRatios.forEach { model in
			let circle = UIView()
			circle.setFrame(.init(squared: 8))
			circle.circleFrame = .init(origin: .zero, size: .init(squared: 8))
			circle.backgroundColor = model.color
			let label = model.name.generateLabel
			let stack = UIStackView.HStack(subViews: [circle, label], spacing: 4, alignment: .center)
			legends.addArrangedSubview(stack)
		}
		
		let progressView = MultipleStrokeProgressBar(frame: .init(origin: .zero, size: .init(width: .totalWidth - 20, height: 24)))
		progressView.setFrame(height: 24)
		
		let stack = UIView.VStack(subViews: [header, balance, legends, progressView], spacing: 5, alignment: .leading)
		stack.setCustomSpacing(12, after: header)
		stack.setCustomSpacing(15, after: balance)
		stack.setFittingConstraints(childView: progressView, leading: 0, trailing: 0)
		progressView.configureProgressBar(ratios: accountRatios)
		view?.setupHeaderView(view: stack.embedInView(insets: .init(by: 10), priority: .needed))
	}
	
	//MARK: - CellProviders
	private var addCardCell: CollectionCellProvider {
		let view = UIView()
		let button = LabelButton()
		button.configure(model: .init(title: "Add Card", img: .init(systemName: "plus") ?? .solid(color: .clear), action: addCardTarget))
		view.addSubview(button)
		view.setFittingConstraints(childView: button, centerX: 0,centerY: 0)
		view.border(color: .surfaceBackgroundInverse, borderWidth: 0.25, cornerRadius: 12)
		return CollectionItem<CustomCollectionCell>(.init(view: view, inset: .init(by: 10)))
	}
	
	private var cardCells: [TableCellProvider] {
		guard let validCards = cards else { return [] }
		let collectionCells = validCards.compactMap { card in CollectionItem<CardViewCollectionCell>(.init(card: card, action: {
			CardStorage.selectedCard = card
			NotificationCenter.default.post(name: .showCard, object: nil)
		}))}
		let h: CGFloat = 200
		return [TableRow<CollectionTableCell>(.init(cells: collectionCells + [addCardCell], inset: .zero, cellSize: .init(width: h * 1.755,
																											height: h)))]
	}
	
	private var accountCells: [TableCellProvider]  {
		let accounts: [AccountModel] = [.init(accountId: UUID().uuidString, name: "AED Account", currency: "AED", balance: Float.random(in: 100..<1000)),
										.init(accountId: UUID().uuidString, name: "BTC Account", currency: "BTC", balance: Float.random(in: 100..<1000), isCrypto: true),
										.init(accountId: UUID().uuidString, name: "ZFI Account", currency: "ZFI", balance: Float.random(in: 100..<1000), isCrypto: true)]
		return accounts.map { account in  TableRow<AccountCardTableCell>(.init(account: account, action: {
			AccountStorage.selectedAccount = account
			NotificationCenter.default.post(name: .showAccount, object: nil)
		})) }
	}
	
	private var txnCells: [TableCellProvider] {
		transactions?.compactMap { TableRow<TransactionCell>(.init(transaction: $0)) } ?? []
	}
	
	private var weeklySpendingChart: UIView {
		let view = WeeklyChartView()
		view.configureChart(.init(daily: Array(repeating: TransactionDailyModel(txns: Array(repeating: TransactionModel(detail: "Sample"),
																							count: Int.random(in: 10..<100))) , count: 7)))
		return view
	}
	
	//MARK: - Sections
	
	private var summarySection: TableSection {
		let percent = Float.random(in: 10..<40)
		let imgView = UIImageView(image: .IconCatalogue.coins.image)
		imgView.frame = .init(origin: .zero, size: .init(squared: 22))
		let cells: [AccountSummaryModel] = [.init(topView: circleChart(percent/40),
												  title: String(format: "%.2f", (percent/40.0) * 100) + " %",
												  subTitle: "Budget Spent"),
											.init(topView: imgView, title: "\(Int.random(in: 10..<100))", subTitle: "Z Coins")]
		let collectionCells = cells.compactMap { CollectionItem<AccountSummaryCollectionCell>(.init(model: $0, action: showAnalytics)) }
		return .init(rows: [TableRow<CollectionTableCell>(.init(cells: collectionCells, cellSize: .init(width: 125, height: 100)))],
					 title: "Spending Summary")
	}
	
	private var accountSection: TableSection {
		.init(rows: accountCells, title: "Accounts")
	}
	
	private var cardSection: TableSection {
		return .init(rows: cardCells, title: "Card")
	}
	
	private var transactionSection: TableSection {
		.init(rows: txnCells + [moreButton(titleString: "view more")], title: "Transactions")
	}
	
	
	private var creditScoreView: TableSection {
		let creditScoreView = CreditScoreView()
		creditScoreView.configureView(.init(score: 750))
		let view = UIView()
		view.addSubview(creditScoreView)
		view.setFittingConstraints(childView: creditScoreView, top: 0, leading: 10, trailing: 10, bottom: 0, centerX: 0, priority: .needed)
		return .init(rows: [TableRow<CustomTableCell>(.init(view: view, inset: .zero))],
					 title: "Credit Card Score")
	}
	
	private var weeklySpendingChartSection: TableSection {
		return .init(rows: [TableRow<CustomTableCell>(.init(view: weeklySpendingChart, inset: .init(by: 10)))], title: "Weekly Chart")
	}
	
	//MARK: - TableViewDataSource
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [cardSection, accountSection, transactionSection, summarySection])
	}
	
	//MARK: - MISC
	@objc
	func addCardTarget() {
		print("(DEBUG) add Target!")
	}
	
	private func showAnalytics() {
		callUpdate(.showAnalytics)
	}
}

extension WalletViewModel {
	enum Events {
		case showAnalytics
		case showWallet
	}
	
	private func callUpdate(_ event: Events) {
		bindings[event]??()
	}
	
	public func addBindings(_ event: WalletViewModel.Events, action: Callback?) {
		bindings[event] = action
	}
}
