//
//  NFCViewController.swift
//  RamiLeviApp
//
//  Created by Ruben Mimoun on 01/03/2021.
//

import Foundation
import CoreNFC
import UIKit

protocol NFCReaderDelegate {
    
    func returnResult(result : String)
}

class NFCViewController : BaseActionsViewController {
    
    var session : NFCNDEFReaderSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNfcSession()
    }
    
    func initNfcSession(){
        type = .nfc
        session =  NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
        session?.alertMessage = "Hold your iPhone near an NFC tag to read the message."
        session?.begin()
    }
    
    private func handleError(_ error: Error) {
        session?.alertMessage = error.localizedDescription
        session?.invalidate()
        delegate?.dismiss()
        Router.showWebRoot(urlString: Result(nil, error), from: type)

    }
    
}

extension NFCViewController : NFCNDEFReaderSessionDelegate{
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("ERROR NFC \(error.localizedDescription)" )
        delegate?.dismiss()
        Router.showWebRoot(urlString: Result(nil, error), from: type)

    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        readMessage(messages: messages)
    }
    
    func readMessage(messages : [NFCNDEFMessage]){
        var result : [String] = []
        for message in messages {
            result.append(message.records.map{String(data: $0.payload, encoding: .ascii)}.description)
        }
        delegate?.dismiss()
        Router.showWebRoot(urlString: Result(result.description, nil), from: .nfc)

    }
    
    @available(iOS 13.0, *)
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        tags.forEach{print($0.debugDescription)}
        guard let tag = tags.first else {return}
        // 1
        session.connect(to: tag) { error in
            if let error = error {
                self.handleError(error)
                return
            }
            
            // 2
            tag.queryNDEFStatus { status, _, error in
                if let error = error {
                    self.handleError(error)
                    return
                }
                
                tag.readNDEF { messsages, error in
                    DispatchQueue.main.async {[unowned self]  in
                        if let message = messsages {
                            let result = message.records.map{String(data: $0.payload, encoding: .ascii) }
                            delegate?.dismiss()
                            Router.showWebRoot(urlString: Result(result.description, nil), from: .nfc)

                            
                        }
                    }
                }
                
                
            }
        }
        
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        
    }
    
}
