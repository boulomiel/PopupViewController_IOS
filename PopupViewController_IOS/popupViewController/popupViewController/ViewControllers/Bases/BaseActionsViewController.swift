//
//  BaseActionsViewController.swift
//  RamiLeviApp
//
//  Created by Ruben Mimoun on 14/03/2021.
//

import UIKit

enum ErrorEnum {
    case back, permission, video, camera, scanning, recognizer, speech
    
    var title : String {
        switch self{
        case .back:
            return "Back Button Pressed"
        case .permission:
            return "No Permission Given "
        case .video:
            return "No video"
        case .camera:
            return "Camera"
        case .scanning:
            return "Scanning error"
        case .recognizer:
            return "Recognizer Error"
        case .speech:
            return "Speech Recognition"

        }
    }
    
    var description : String {
        switch self{
        case .back:
            return "Pressing the back button forced the current activity to stop"
        case .permission:
            return "The device is missing a user permission to use this functionality"
        case .video:
            return "The device didn't allow the use of video"
        case .camera:
            return "Could not access the camera"
        case .scanning:
            return "Scanning Not Supported by the device"
        case .recognizer:
            return "Recognizer not supported"
        case .speech:
            return "User denied access to speech recognition"

        }
    }
}

typealias Result = (String?, Error?)

enum Sender {
    case qr , nfc , speach , barcode
    
    var capabiity : String {
        switch self {
        case .qr:
            return "ScanBarcodeFromCamera"
        case .nfc:
            return "GetReaderNFC"
        case .speach:
            return "GetVoiceText"
        case .barcode:
            return "ScanBarcodeFromScanner"
        }
    }


}

protocol ErrorProtocol : LocalizedError {
    var type: ErrorEnum { get }
}

struct CancelError : ErrorProtocol {
    var type: ErrorEnum
    private var title : String
    private var description : String
    
    init(type : ErrorEnum) {
        self.type = type
        self.title = type.title
        self.description = type.description
    }
}

class BaseActionsViewController: UIViewController {
    
    var type : Sender!
    
    weak var delegate : PopupViewControllerDelegate?
    
    convenience init(delegate : PopupViewControllerDelegate) {
        self.init()
        self.delegate =  delegate

    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton

    }
    
    @objc func back(_ sender: UIBarButtonItem) {
        Router.showWebRoot(urlString: Result(nil, CancelError(type: .back) ), from: type)
    }
    
    func handleCancelError(error : ErrorEnum){
        Router.showWebRoot(urlString: Result(nil, CancelError(type: error) ), from: type)
    }


}

extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }
        child.view.layer.masksToBounds = true
        child.view.translatesAutoresizingMaskIntoConstraints = true

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
