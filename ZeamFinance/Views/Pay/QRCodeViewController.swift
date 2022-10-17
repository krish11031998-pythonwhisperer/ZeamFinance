//
//  QRCodeViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 09/10/2022.
//

import Foundation
import AVFoundation
import UIKit

class QRCodeReaderViewController<T:Codable>: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
	
	//MARK: - Properties
	private lazy var closeButton: UIButton = {
		let button = UIButton(frame: .init(origin: .zero, size: .init(squared: 25)))
		button.setImage(.init(systemName: "xmark")?.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal), for: .normal)
		button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
		return button
	}()
	private var captureSession: AVCaptureSession?
	private var previewLayer: AVCaptureVideoPreviewLayer?
	private var onCompletion: ((T?) -> Void)?
	
	//MARK: - Overriden
	
	init(handler: ((T?) -> Void)? = nil) {
		super.init(nibName: nil, bundle: nil)
		self.onCompletion = handler
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .surfaceBackground
		setupNavbar()
		loadCaptureSession()
		preferredContentSize = .init(width: .totalWidth, height: .totalHeight.half)
		view.cornerRadius(16, corners: .top)
		view.clipsToBounds = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		if (captureSession?.isRunning == false) {
			DispatchQueue.global(qos: .background).async {
				self.captureSession?.startRunning()
			}
		}
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		if (captureSession?.isRunning == true) {
			DispatchQueue.global(qos: .background).async {
				self.captureSession?.stopRunning()
			}
		}
	}
	
	//MARK: - ProtecteMethods

	private func setupNavbar() {
		mainPageNavBar(title: "Scan QR Code", rightBarButton: .init(customView: closeButton))
		navigationController?.additionalSafeAreaInsets.top = 10
		navigationController?.navigationBar.clipsToBounds = true
	}
	
	@objc
	private func closeModal() {
		dismiss(animated: true)
	}
	
	//MARK: - QRCode Reader Function
	private func loadCaptureSession() {
		captureSession = AVCaptureSession()
		
		guard let captureSession = self.captureSession, let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
		let videoInput: AVCaptureDeviceInput
		
		do {
			videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
		} catch {
			return
		}
		
		if (captureSession.canAddInput(videoInput)) {
			captureSession.addInput(videoInput)
		} else {
			failed()
			return
		}
		
		let metadataOutput = AVCaptureMetadataOutput()
		
		if (captureSession.canAddOutput(metadataOutput)) {
			captureSession.addOutput(metadataOutput)
			
			metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
			metadataOutput.metadataObjectTypes = [.qr]
		} else {
			failed()
			return
		}
		
		previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		previewLayer!.frame = view.layer.bounds
		previewLayer!.frame.origin.y = (navigationController?.navigationBar.compressedSize.height ?? 0) + (navigationController?.additionalSafeAreaInsets.top ?? 0)
		previewLayer?.frame.size.height = view.layer.bounds.height - (previewLayer?.frame.origin.y ?? 0)
		previewLayer!.videoGravity = .resizeAspectFill
		view.layer.addSublayer(previewLayer!)
		
		DispatchQueue.global(qos: .background).async {
			captureSession.startRunning()
		}
	}
	
	private func failed() {
		let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default))
		present(ac, animated: true)
		captureSession = nil
	}
	
	func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
		captureSession?.stopRunning()

		if let metadataObject = metadataObjects.first {
			guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
			guard let data = readableObject.stringValue else { return }
			AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
			guard let decodedData = try? JSONDecoder().decode(T.self, from: Data(data.utf8)) else {
				onCompletion?(nil)
				 return
			}
			onCompletion?(decodedData)
		}

		closeModal()
	}

	private func found(code: String) {
		print(code)
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return .portrait
	}
}
