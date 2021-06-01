//
//  ItemSelectedViewController.swift
//  Swiich
//
//  Created by Ruben Mimoun on 13/05/2021.
//  Copyright © 2021 עלי חלאחלה. All rights reserved.
//

import Foundation
import UIKit
import CoreData
enum PopType {
    case speach , barcode, nfc , scanner
}

protocol PopupViewControllerDelegate : class {
    
    func dismiss()
}
class PopupViewController: UIViewController, PopupViewControllerDelegate {

    

    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var buttonBar : UIView!
    @IBOutlet weak var holderView : UIView!
    var type : PopType  = .speach
    var vc : BaseActionsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        switch type {
        case .barcode:
            vc  = BarCodeScannerViewController(delegate: self)
            add(vc, frame: CGRect(x: 20, y: 140, width: contentView.frame.width, height: holderView.frame.height))
        case .nfc:
            vc  = NFCViewController(delegate: self)
            add(vc, frame: CGRect(x: 20, y: 140, width: contentView.frame.width, height: holderView.frame.height))
        case .speach:
            vc  = SpeechRecognitionViewController(delegate: self)
            add(vc, frame: CGRect(x: 20, y: 140, width: contentView.frame.width, height: holderView.frame.height))
        case .scanner:
            vc  = QRViewController(delegate: self)
            add(vc, frame: CGRect(x: 20, y: 140, width: contentView.frame.width, height: holderView.frame.height))
        }

    }

    private func initView(){
        self.view.layer.cornerRadius = 15
        self.contentView.layer.cornerRadius = 15
        self.holderView.layer.cornerRadius = 15
        self.holderView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.contentView.layer.masksToBounds = true
        self.buttonBar.layer.masksToBounds = true

    }
    
    
    @IBAction func closeView(){
        remove()
        self.dismiss(animated: true) {
            
        }
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    


}
