//
//  File.swift
//  RamiLeviApp
//
//  Created by Ruben Mimoun on 01/03/2021.
//

import Foundation
import UIKit

enum ApplicationStoryboard : String{
    
    case login,main
    
    var storyboard : UIStoryboard {
        switch self {
        default:
            return UIStoryboard(name: self.rawValue.capitalized, bundle: Bundle.main)
        }
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T? {
        
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardId
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as? T
    }
    
    func initialViewController() -> UIViewController? {
        return storyboard.instantiateInitialViewController()
    }
    
}

extension UIViewController {
    
    class var storyboardId: String {
        return "\(self)"
    }
    
    static func instantiate(from storyboard: ApplicationStoryboard) -> Self? {
        return storyboard.viewController(viewControllerClass: self)
    }
}

