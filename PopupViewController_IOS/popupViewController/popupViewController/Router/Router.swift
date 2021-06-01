//
//  Router.swift
//  RamiLeviApp
//
//  Created by Ruben Mimoun on 01/03/2021.
//

import Foundation
import UIKit

class Router {
    
    class var window: UIWindow? {
        return  UIApplication.shared.windows.first
    }
    // Main Navigation is root view controller
    class var mainNavigation: UINavigationController? {
        return self.window?.rootViewController as? UINavigationController
    }
    
    static func setRootViewController(controller: UIViewController?, animated: Bool) {
        guard let window = self.window else { return }
        window.rootViewController = controller
        if animated == true {
            UIView.transition(with: window, duration: 0.35, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    
    static func showMain(animated: Bool = true) {
        self.setRootViewController(controller: ApplicationStoryboard.main.initialViewController(), animated: true)
    }
    
    static func showLogin(animated: Bool = true) {
            self.setRootViewController(controller: ApplicationStoryboard.login.initialViewController(), animated: animated)    
    }
    
    static func showQR(){
        let popUp =  PopupViewController()
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.type = .scanner
        if let root = window?.rootViewController{
            root.present(popUp, animated: true, completion: nil)
        }
    }
    
    static func showNFC(){
        let popUp =  PopupViewController()
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.type = .nfc
        if let root = window?.rootViewController{
            root.present(popUp, animated: true, completion: nil)
        }
    }
    static func showBarCode(){
        let popUp =  PopupViewController()
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.type = .barcode
        if let root = window?.rootViewController{
            root.present(popUp, animated: true, completion: nil)
        }
    }
    
    static func showSpeech(){
        let popUp =  PopupViewController()
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.type = .speach
        if let root = window?.rootViewController{
            root.present(popUp, animated: true, completion: nil)
        }
    }
    
    static func showWebRoot(urlString : Result, from sender :  Sender){
        if let navigation = mainNavigation {
            if let root = navigation.viewControllers.first {
                (root as? ViewController)!.returnResult(result: urlString, sender: sender)
            }
        }
    }
    

    
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
