//
//  PresentationViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

fileprivate extension UIView {
	
	var preferredHeight: CGFloat {
		
		switch self {
		case let scrollView as UIScrollView:
			return min(scrollView.contentSize.height,.totalHeight) + scrollView.contentInset.top + scrollView.contentInset.bottom
		default:
			return compressedSize.height
		}
	}
	
}

fileprivate extension UIViewController {
	
	var preferHeight: CGFloat {  preferredContentSize.height > 0 ? preferredContentSize.height : computeHeight() }
	
	func computeHeight() -> CGFloat {
		let insets = view.safeAreaInsets.top + view.safeAreaInsets.bottom
		var height = view.compressedSize.height + insets
		
		if let tableView = view as? UITableView {
			height += tableView.contentSize.height + tableView.contentInset.top + tableView.contentInset.bottom
		}
		
		if view.subviews.count > 0 {
			return view.subviews.compactMap { $0.preferredHeight }.sorted { $0 < $1 }.last ?? .zero + insets
		}
		
		return height
	}
}


class PresentationViewController: UIPresentationController {
	
	//MARK: - Properties
	private lazy var dimmingView: UIView =  {
		let view = UIView()
		view.addBlurView()
		view.layer.opacity = 0
		return view
	}()
	
	//MARK: - Overriden Methods
	override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
		super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
		addGestureToDimmiingView()
	}
	
	override var frameOfPresentedViewInContainerView: CGRect {
		let navigation = presentedViewController as? UINavigationController
		let header = (navigation?.navigationBar.frame.height ?? 0) + (navigation?.additionalSafeAreaInsets.top ?? 0)
		
		let nestedController = (presentedViewController as? UINavigationController)?.viewControllers.last ?? presentedViewController
		
		guard let bounds = containerView?.bounds,
			  let screenInsets = UIWindow.key?.safeArea
		else { return UIScreen.main.bounds }
		print("(DEBUG) height is being computed! : ",nestedController.preferHeight)
		let extraPadding = screenInsets.bottom + nestedController.additionalSafeAreaInsets.top + nestedController.additionalSafeAreaInsets.bottom + header
		var frame = bounds
		frame.size.height = min(nestedController.preferHeight + extraPadding, bounds.height - UIWindow.statusBarFrame.height + 20)
		frame.origin.y = bounds.height - frame.size.height
		return frame
	}
	
	
	override func presentationTransitionWillBegin() {
		containerView?.insertSubview(dimmingView, at: 0)
		containerView?.setFittingConstraints(childView: dimmingView, insets: .zero)
		
		guard let coordinator = presentedViewController.transitionCoordinator else {
			dimmingView.layer.opacity = 1
			return
		}
		
		coordinator.animate { _ in
			self.dimmingView.layer.opacity = 1
		}
		
	}
	
	
	override func dismissalTransitionWillBegin() {
		guard let coordinator = presentedViewController.transitionCoordinator else {
			dimmingView.layer.opacity = 0
			return
		}
		
		coordinator.animate { _ in
			self.dimmingView.layer.opacity = 0
		} completion: { _ in
			self.dimmingView.removeFromSuperview()
		}
	}
	
	override func containerViewWillLayoutSubviews() {
		presentedView?.frame = frameOfPresentedViewInContainerView
	}
	
	//MARK: - Protected Methods
	
	private func addGestureToDimmiingView() {
		dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeOnTap)))
	}
	
	@objc
	private func closeOnTap() {
		presentedViewController.dismiss(animated: true)
	}
}

extension PresentationViewController: UIViewControllerTransitioningDelegate {
	
	func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
		self
	}
	
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		self
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		self
	}
}


extension PresentationViewController: UIViewControllerAnimatedTransitioning {
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { 0.3 }
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let isPresented = presentedViewController.isBeingPresented
		let key: UITransitionContextViewControllerKey = isPresented ? .to : .from
		
		guard let controller = transitionContext.viewController(forKey: key) else { return }
		
		if isPresented {
			transitionContext.containerView.addSubview(controller.view)
		}
		
		let presentedFrame = transitionContext.finalFrame(for: controller)
		var dismisedFrame = presentedFrame
		dismisedFrame.origin.y = transitionContext.containerView.bounds.height
		
		
		let initialFrame = isPresented ? dismisedFrame : presentedFrame
		let finalFrame = isPresented ? presentedFrame : dismisedFrame
		
		let duration = transitionDuration(using: transitionContext)
		controller.view.frame = initialFrame
		UIView.animate(withDuration: duration) {
			controller.view.frame = finalFrame
		} completion: { isFinished in
			guard isFinished else { return }
			if !isPresented {
				controller.view.removeFromSuperview()
			}
			
			transitionContext.completeTransition(isFinished)
		}
	}
	
	
}
