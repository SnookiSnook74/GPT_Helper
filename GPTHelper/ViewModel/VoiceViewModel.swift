//
//  VoiceViewModel.swift
//  GPTHelper
//
//  Created by DonHalab on 07.01.2024.
//

import Foundation
import OpenAI
import AVFoundation

class VoiceViewModel {
   
    var messages: [Chat] = []
    private let openAI = OpenAI(apiToken: "")
    var audioPlayer: AVAudioPlayer?
    
    func voice(_ messages: String) async {
        let query = AudioSpeechQuery(model: .tts_1, input: messages, voice: .alloy, responseFormat: .mp3, speed: 1.0)

        do {
            let result = try await openAI.audioCreateSpeech(query: query)
            if let audioData = result.audioData {
                audioPlayer = try AVAudioPlayer(data: audioData)
                audioPlayer?.play()
            }
        } catch {
            print("error \(error)")
        }
    }
    
}
