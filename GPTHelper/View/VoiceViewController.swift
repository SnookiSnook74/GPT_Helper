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

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let instruction: UILabel = {
        let instruction = UILabel()
        instruction.text = "Нажмите и задайте вопрос"
        instruction.font = .systemFont(ofSize: 20, weight: .bold)
        instruction.textAlignment = .center
        instruction.translatesAutoresizingMaskIntoConstraints = false
        return instruction
    }()

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

    let voiceAnimate: AudioVisualizationView = {
        let voiceAnimate = AudioVisualizationView()
        voiceAnimate.translatesAutoresizingMaskIntoConstraints = false
        voiceAnimate.isHidden = true
        return voiceAnimate
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
        stackView.addArrangedSubview(voiceButton)
        stackView.addArrangedSubview(instruction)
        view.addSubview(stackView)
        view.addSubview(voiceAnimate)
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

        voiceAnimate.isHidden = false
        stackView.isHidden = true
        voiceAnimate.startAnimating()

        do {
            let audioData = try Data(contentsOf: audioFilename)
            Task {
                await result = gptVoice.voiceConvert(data: audioData)
                await gptChat.sendMessage(result)
                await gptVoice.voice(messages.last?.content ?? "Повтори")
                // Переменная которая помогает сохранить переходы между чатом и голосом
                indexCount += 2
                voiceAnimate.isHidden = true
                stackView.isHidden = false
                voiceAnimate.stopAnimating()
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
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),

            voiceButton.widthAnchor.constraint(equalToConstant: 150),
            voiceButton.heightAnchor.constraint(equalToConstant: 150),

            voiceAnimate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            voiceAnimate.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            voiceAnimate.widthAnchor.constraint(equalToConstant: 150),
            voiceAnimate.heightAnchor.constraint(equalToConstant: 150),

        ])
    }
}
