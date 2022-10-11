//
//  ProfileImaegView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 06/10/2022.
//

import Foundation
import UIKit

struct ProfileModel {
	let profileImg: UIImage?
	let profileImgURL: String?
	let username: String
	let accountNumber: String
	
	init(profileImg: UIImage? = nil, profileImgURL: String? = nil, username: String, accountNumber: String) {
		self.profileImg = profileImg
		self.profileImgURL = profileImgURL
		self.username = username
		self.accountNumber = accountNumber
	}
}

class ProfileView: UIView {
	
	private lazy var profileImg: UIImageView = {
		let imgView = UIImageView()
		imgView.cornerRadius = 45
		imgView.setFrame(.init(squared: 90))
		imgView.circleFrame = .init(origin: .zero, size: .init(squared: 90))
		imgView.layer.addCircularProgress(startAngle: 0,
										  endAngle: 2 * .pi,
										  lineWidth: 5,
										  strokeColor: .surfaceBackgroundInverse,
										  clockwise: true,
										  animateStrokeEnd: false)
		imgView.backgroundColor = .popWhite100
		return imgView
	}()
	
	private lazy var userInfo: DualLabel = { .init() }()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func setupView() {
		let view = UIStackView.VStack(subViews: [profileImg, userInfo],
									  spacing: 12,
									  alignment: .center)
		addSubview(view)
		setFittingConstraints(childView: view, insets: .zero)
	}
	
	public func configureProfileView(_ model: ProfileModel) {
		if let validimg = model.profileImg {
			profileImg.image = validimg
		} else if let validURL = model.profileImgURL {
			UIImage.loadImage(url: validURL, at: profileImg, path: \.image)
		}
		
		userInfo.configureLabel(title: model.username.bold(size: 20),
								subTitle: model.accountNumber.semiBold(size: 14),
								config: .init(alignment: .center, axis: .vertical, subTitleNumberOfLines: 0))
	}
}
