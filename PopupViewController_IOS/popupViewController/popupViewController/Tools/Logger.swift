//
//  Logger.swift
//  commix
//
//  Created by Daniel Radshun on 04/01/2021.
//

import Foundation

class Logger {
    static let shared = Logger()
     func log(className : String, method : String , message : String){
        print("\(className) => \(method) => \(message)")
    }
}
