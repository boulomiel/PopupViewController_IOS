//
//  SpeechRecognitionViewController.swift
//  RamiLeviApp
//
//  Created by Ruben Mimoun on 01/03/2021.
//

import Foundation
import UIKit
import Speech

class SpeechRecognitionViewController: BaseActionsViewController{
    
    @IBOutlet  var detectedTextLabel: UILabel?
    @IBOutlet  var searchButton: UIButton?
    
    let audioEngine : AVAudioEngine? =  AVAudioEngine()
    let speechRecognizer : SFSpeechRecognizer? =  SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask : SFSpeechRecognitionTask?
    var speech : String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        type = .speach
        initSearchButton()
        recordAndRecognizeSpeech()
    }

    func initSearchButton(){
        if detectedTextLabel == nil {
            detectedTextLabel?.removeFromSuperview()
            detectedTextLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0  , y: 20 ), size: CGSize(width: self.view.frame.width  , height: 25)))
            detectedTextLabel?.numberOfLines = 3
            view.addSubview(detectedTextLabel!)
            view.bringSubviewToFront(detectedTextLabel!)

        }
        
        if searchButton ==  nil {
            searchButton?.removeFromSuperview()
            searchButton = UIButton(frame:CGRect(origin: CGPoint(x: self.view.frame.width / 2 - 80 , y:  180), size: CGSize(width: 80, height: 20)))
            searchButton?.addTarget(self, action: #selector(showMainRoot(_:)), for: .touchDown)
            view.addSubview(searchButton!)
            view.bringSubviewToFront(searchButton!)

            
        }
        searchButton?.backgroundColor = .red
        searchButton?.setTitle("Go", for: .normal)
        searchButton?.layer.masksToBounds = false
        searchButton?.layer.cornerRadius = 12
        searchButton?.layer.shadowRadius  = 5
        searchButton?.layer.shadowOpacity = 0.4
        searchButton?.layer.shadowOffset = CGSize(width: 2, height: 0)
        
        
    }
    
    func recordAndRecognizeSpeech(){
        guard let node = audioEngine?.inputNode else {return}
        let recordingFormat  = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {  buffer , _ in
            self.request.append(buffer)
        }
        
        audioEngine?.prepare()
        do{
            try audioEngine?.start()
        }catch{
            Router.showWebRoot(urlString: Result(nil, error), from: type)

            return
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else {
            handleCancelError(error: .recognizer)

            return}
        
        if !myRecognizer.isAvailable {
            handleCancelError(error: .recognizer)

            return
        }
        
        recognitionTask =  speechRecognizer?.recognitionTask(with: request, resultHandler: { [unowned self] result, error in
            if let result = result {
                self.detectedTextLabel?.text = result.bestTranscription.formattedString
                self.speech =  result.bestTranscription.formattedString

            }else  {
            }
        })
    }
    
    
    @objc func showMainRoot(_ sender : UIButton){
        delegate?.dismiss()
        Router.showWebRoot(urlString: Result(speech, nil), from: .speach)
    }
    
    @IBAction func searchButton(_ sender : Any){
        Router.showWebRoot(urlString: Result(speech, nil), from: .speach)
    }
}
