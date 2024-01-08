//
//  VoiceViewController.swift
//  GPTHelper
//
//  Created by DonHalab on 07.01.2024.
//

import AVFoundation
import UIKit

class VoiceViewController: UIViewController {
    var audioRecorder: AVAudioRecorder?
    let gptVoice = VoiceViewModel()
    let gptChat = GptViewModel()

    let voiceButton: UIButton = {
        let voiceButton = UIButton()
        voiceButton.translatesAutoresizingMaskIntoConstraints = false
        voiceButton.layer.cornerRadius = 75
        voiceButton.clipsToBounds = true
        if let image = UIImage(named: "voice") {
            voiceButton.setBackgroundImage(image, for: .normal)
        }

        return voiceButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubview()
        setupConstraint()
        setupVoiceButton()
        setupAudioSession()
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
        try? audioSession.overrideOutputAudioPort(.speaker)
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
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
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
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("voiceRecording.m4a")
        var result = ""

        do {
            let audioData = try Data(contentsOf: audioFilename)
            Task {
                await result = gptVoice.voiceConvert(data: audioData)
                await gptChat.sendMessage(result)
                await gptVoice.voice(messages.last?.content ?? "Повтори")
            }

        } catch {
            print("Error loading audio data: \(error)")
        }
        audioRecorder = nil
    }
}

extension VoiceViewController {
    func setupConstraint() {
        NSLayoutConstraint.activate([
            voiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            voiceButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            voiceButton.widthAnchor.constraint(equalToConstant: 150),
            voiceButton.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
}
