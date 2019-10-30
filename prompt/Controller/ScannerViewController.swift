import AVFoundation
import UIKit

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var overlay:UIImageView = {
    let scanImage = UIImage(named:"scan")
    let overlayView = UIImageView()
        overlayView.image = scanImage
    return overlayView
    }()
    
    
    var profileButton:UIButton = {
    let profileButton  = UIButton(type: .custom)
    profileButton.setImage(UIImage(named: "profile.png"), for: .normal)
    profileButton.translatesAutoresizingMaskIntoConstraints = false
    return profileButton
    }()
    
    var restoButton:UIButton = {
    let profileButton  = UIButton(type: .custom)
    profileButton.setImage(UIImage(named: "resto.png"), for: .normal)
    profileButton.translatesAutoresizingMaskIntoConstraints = false
    return profileButton
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
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
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        self.attachOverlay(overlayImage: overlay)
        self.attachProfileButton(profileButton: profileButton)
        self.attachRestoButton(resto: restoButton)
        captureSession.startRunning()
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
//        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

        dismiss(animated: true)
    }

    func found(code: String) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MenuViewController") 
        
        self.navigationController?.pushViewController(vc, animated: true)
    }


    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    func attachOverlay(overlayImage: UIImageView?) {
        self.view.addSubview(overlay)
        overlay.translatesAutoresizingMaskIntoConstraints = false
//        overlay.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:40).isActive = true
        overlay.centerXAnchor.constraint(equalTo:self.view.centerXAnchor).isActive = true
        overlay.centerYAnchor.constraint(equalTo:self.view.centerYAnchor).isActive = true
        overlay.heightAnchor.constraint(equalToConstant:200).isActive = true
        overlay.widthAnchor.constraint(equalToConstant:200).isActive = true
    }
    
    func attachProfileButton(profileButton: UIButton) {
        self.view.addSubview(profileButton)
        profileButton.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        profileButton.leftAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
    }
    func attachRestoButton(resto: UIButton) {
        self.view.addSubview(resto)
        resto.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        resto.rightAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    }
}
