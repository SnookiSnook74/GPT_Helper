//
//  VoiceViewController.swift
//  GPTHelper
//
//  Created by DonHalab on 07.01.2024.
//


import UIKit
import AVFoundation

class VoiceViewController: UIViewController {

    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    let gptModel = VoiceViewModel()
    
    
    let voiceButton: UIButton = {
        let voiceButton = UIButton()
        voiceButton.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        voiceButton.backgroundColor = .black
        voiceButton.setTitle("Нажмите и держите для записи", for: .normal)
        return voiceButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubview()
        setupVoiceButton()
        setupAudioSession()
    }


}

// MARK: - Вопроизведение записи
extension VoiceViewController {
    func playRecording() {
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("voiceRecording.m4a")

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer?.play()
        } catch {
            print("Error \(error)")
        }
    }
}

// MARK: - Настройки
extension VoiceViewController {
    func setupSubview() {
        view.addSubview(voiceButton)
    }
    
    private func setupVoiceButton() {
        voiceButton.addTarget(self, action: #selector(startRecording), for: .touchDown)
        voiceButton.addTarget(self, action: #selector(stopRecording), for: [.touchUpInside, .touchUpOutside])
    }

    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playAndRecord, mode: .default)
        try? audioSession.setActive(true)
    }

}

// MARK: - Методы для записи и остановки
extension VoiceViewController {
    @objc func startRecording() {
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("voiceRecording.m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.record()
        } catch {
           print("Error \(error)")
        }
    }

    @objc func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        playRecording()
    }
}
