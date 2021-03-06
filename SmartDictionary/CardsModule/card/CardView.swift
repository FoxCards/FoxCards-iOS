//
//  CardView.swift
//  SmartDictionaty
//
//  Created by Андрей Коноплев on 21.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class CardView: SwipableViews {
    
    @IBOutlet weak var langImg: UIImageView!
    @IBOutlet weak var voiceButton: UIButton!
    @IBOutlet weak var voiceLabel: UILabel!
    @IBOutlet weak var audioButton: UIButton!
    
    weak var vc: CardsViewController?
    let CardFronTag = 1
    let CardBackTag = 2
    var cardView: (frontLabel: UILabel, backLabel: UILabel)?
    var frontLabel: UILabel!
    var backLabel: UILabel!
    //MARK: - speach
    var audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: const.app_settings.app_language?.speach_locale ?? ""))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var voiceFlag = false
 
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.layer.cornerRadius = 30
        checkAllowedMicrophone()
    }
    
    func configure(obj: Word,vc: CardsViewController ,frame: CGRect) {
        self.vc = vc
        langImg.image = UIImage(named: const.app_settings.app_language?.speach_locale ?? "")
        if frontLabel == nil || backLabel == nil {
            frontLabel = self.createdCardWithLabel(labelTitle: "", frame: frame, tag: CardFronTag)
            backLabel = self.createdCardWithLabel(labelTitle: "", frame: frame, tag: CardBackTag)
            frontLabel.numberOfLines = 0
            backLabel.numberOfLines = 0
            frontLabel.textAlignment = .center
            backLabel.textAlignment = .center
            cardView = (frontLabel: frontLabel, backLabel: backLabel)
            self.addSubview(frontLabel)
        }
        
        frontLabel.text = obj.word
        backLabel.text = obj.translate
        if frontLabel.superview == nil {
            flipCard()
        }
        voiceButton.isSelected = false
        recognitionTask?.cancel()

        voiceLabel.text = ""
    }
    
    func createdCardWithLabel(labelTitle: String,frame: CGRect, tag: Int)-> UILabel {
        let label = UILabel(frame: CGRect(x: 0 , y: 0 , width: frame.width - 130, height: 100))
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = labelTitle
        label.tag = tag
        return label
    }
    
    func flipCard() {
        if frontLabel.superview != nil {
            cardView = (frontLabel: frontLabel, backLabel: backLabel)
            voiceButton.isHidden = true
            audioButton.isHidden = true
            langImg.isHidden = true
            voiceLabel.text = ""
        } else {
            cardView = (frontLabel: backLabel, backLabel: frontLabel)
            voiceButton.isHidden = false
            audioButton.isHidden = false
            langImg.isHidden = false
            voiceLabel.text = ""
        }
        let transitionOptions = UIViewAnimationOptions.transitionFlipFromLeft
        UIView.transition(with: self, duration: 0.5, options: transitionOptions, animations: {
            self.cardView?.frontLabel.removeFromSuperview()
            self.addSubview((self.cardView?.backLabel)!)
        }) { (finished) in
        }
        
    }
}

extension CardView {
    fileprivate func checkAllowedMicrophone() {
        SFSpeechRecognizer.requestAuthorization { [unowned self] (status) in
            switch status {
            case .authorized:
                DispatchQueue.main.async { [unowned self] in
                    self.voiceButton.isEnabled = true
                }
            case .denied:
                print("denied")
            case .notDetermined:
                print("nowDetermined")
            case .restricted:
                print("restricted")
            }
        }
    }
    
    fileprivate func startRecognition() {
        let node = audioEngine.inputNode
        let recognationFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recognationFormat) { [unowned self] (buffer, audioTime) in
            self.request.append(buffer)
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            print("\(error.localizedDescription)")
            return
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { [unowned self] (result, error) in
            if let result = result {
                DispatchQueue.main.async {
                    [unowned self] in
                    self.voiceLabel.text = result.bestTranscription.formattedString
                }
                if result.isFinal {
                    node.removeTap(onBus: 0)
                }
            } else if let error = error {
                print("\(error.localizedDescription)")
                node.removeTap(onBus: 0)
            }
        })
    }
}

extension CardView {
    //stop voice
    func stopVoice() {
        audioEngine.stop()
        request.endAudio()
        recognitionTask?.cancel()
    }
    
    func safeVoice() {
        if voiceFlag {
            stopVoice()
        }
    }
}

//MARK: - actions
extension CardView {
    @IBAction func flipCard(_ sender: Any) {
        flipCard()
    }
    
    @IBAction func pushToStartRecognition(_ sender: UIButton) {
        if sender.isSelected {
            stopVoice()
            voiceFlag = false
            vc?.voiceUpCard.removeLast()
        } else {
            voiceFlag = true
            startRecognition()
            vc?.voiceUpCard.append(self)
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func playVoice(_ sender: Any) {
        let utterance = AVSpeechUtterance(string:  frontLabel.text ?? "")
        utterance.voice = AVSpeechSynthesisVoice(language: const.app_settings.app_language?.speach_locale)
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
}
