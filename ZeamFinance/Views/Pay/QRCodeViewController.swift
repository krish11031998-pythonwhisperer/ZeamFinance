//
//  QRCodeViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 09/10/2022.
//

import Foundation
import AVFoundation
import UIKit

class QRCodeReaderViewController: UIViewController {
	
	//MARK: - Properties
	private lazy var closeButton: UIButton = {
		let button = UIButton(frame: .init(origin: .zero, size: .init(squared: 25)))
		button.setImage(.init(systemName: "xmark")?.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal), for: .normal)
		button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
		return button
	}()
	private var captureSession: AVCaptureSession?
	private var previewLayer: AVCaptureVideoPreviewLayer?
	
	//MARK: - Overriden
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .surfaceBackground
		setupNavbar()
		loadCaptureSession()
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
	}
	
	@objc
	private func closeModal() {
		dismiss(animated: true)
	}
}

//MARK: - QRCodeReader Functions
extension QRCodeReaderViewController: AVCaptureMetadataOutputObjectsDelegate {
	
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
			found(code: data)
			guard let decodedData = try? JSONDecoder().decode(PaymentQRCodeModel.self, from: Data(data.utf8)) else {
				 return
			}
			print("(DEBUG) Decoded Data : ", decodedData)
			PaymentStorage.selectedPayment = .init(billCompany: decodedData.billCompany,
												   billDescription: decodedData.billDescription,
												   amount: decodedData.amount,
												   billCompanyLogo: .init(), receiptItems: decodedData.receiptItems, type: decodedData.type)
		}

		dismiss(animated: true)
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
