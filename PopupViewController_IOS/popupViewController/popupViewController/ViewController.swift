//
//  ViewController.swift
//  popupViewController
//
//  Created by Ruben Mimoun on 01/06/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func first(_ sender: Any) {
        Router.showQR()
    }
    
    @IBAction func second(_ sender: Any) {
        Router.showNFC()
    }
    
    @IBAction func third(_ sender: Any) {
        Router.showBarCode()
    }
    
    @IBAction func fourth(_ sender: Any) {
        Router.showSpeech()
    }
    
    func returnResult( result: Result  , sender : Sender) {
         
        let success = result.1 == nil ? "success" : "rejected"
        let value : String  =  String((result.1 != nil ? result.1.debugDescription : result.0)!)
        
        switch sender {
        case .qr:
            Alert.setAlert(vc: self, title: "QR", message: value)
            print(" qr did it work ? \(success) , result : \(value)")
            break
        case .nfc:
            Alert.setAlert(vc: self, title: "NFC", message: value)
            break
        case .speach:
            Alert.setAlert(vc: self, title: "Speech", message: value)

        case .barcode :
            Alert.setAlert(vc: self, title: "Barcode", message: value)

            break

        }
       
    }
}

