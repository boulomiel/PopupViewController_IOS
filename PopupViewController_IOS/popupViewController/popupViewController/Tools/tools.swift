//
//  tools.swift
//  RamiLeviApp
//
//  Created by Ruben Mimoun on 30/05/2021.
//

import Foundation
import UIKit


func openApp(appScheme : String , options : [UIApplication.OpenExternalURLOptionsKey : Any] = [:]){
    let app = UIApplication.shared
    if app.canOpenURL(URL(string: appScheme)!) {
        print("App is install and can be opened")
        let url = URL(string:appScheme)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: options, completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
