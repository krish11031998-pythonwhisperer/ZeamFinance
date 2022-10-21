//
//  SpendingAnalyticsBudgetView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 20/10/2022.
//

import Foundation
import UIKit

class SpendingAnalyticsBudgetView: UIView {
    
    private var chartSectionLayers: [CAShapeLayer] = []
    private let colors: [UIColor] = [.success500, .warning500, .error500]
    private lazy var balanceLabel: DualLabel = { .init() }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        for i in 0..<3 {
            let startAngle:CGFloat = -(CGFloat(180 - (i * 60) - 5).boundTo(lower: 0, higher: 180))
            let endAngle:CGFloat = -(CGFloat(180 - (i+1) * 60 + 5).boundTo(lower: 0, higher: 180))
            let layer = layer.addCircularProgress(startAngle: startAngle.toRadians(), endAngle: endAngle.toRadians(), radiusOffset: -20, lineWidth: 10, strokeColor: colors[i], clockwise: true, isSemiCircle: true, animateStrokeEnd: true)
            layer.fillColor = UIColor.clear.cgColor
            chartSectionLayers.append(layer)
        }
        setFrame(frame.size)
        addSubview(balanceLabel)
        setFittingConstraints(childView: balanceLabel,centerX: 0, centerY: frame.height.half.half)
        let titleLabel = "Spend-o-meter".uppercased().bold(size: 12).generateLabel
        addSubview(titleLabel)
        setFittingConstraints(childView: titleLabel, centerX: 0, centerY: 0)
    }
    
    func configureView(budget: CGFloat = .random(in: 100..<1000), maxVal: CGFloat = 1000) {
        var val: CGFloat = (budget * 3)/maxVal
        let color: UIColor = val < 1 ? .success500 : val < 2 ? .warning500 : .error500
        chartSectionLayers.enumerated().forEach { layer in
            let toVal = val > 1 ? 1 : val
            guard toVal >= 0 else { return }
            layer.element.animate(animation: .circularProgress(from: 0, to: toVal, duration: 1, delay: CFTimeInterval(layer.offset) * 1))
            val -= 1
        }
        balanceLabel.configureLabel(title: "Expenses This Month".bold(size: 18), subTitle: String(format: "$ %.2f", budget).medium(color: color, size: 25), config: .init(alignment: .center))
    }
    
    
}
