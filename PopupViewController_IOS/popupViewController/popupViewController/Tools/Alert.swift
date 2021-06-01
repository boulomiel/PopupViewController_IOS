//
//  Alert.swift
//  RamiLeviApp
//
//  Created by Ruben Mimoun on 01/03/2021.
//

import Foundation
import UIKit

class Alert {

    static func setAlert(vc : UIViewController, title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action =  UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}
