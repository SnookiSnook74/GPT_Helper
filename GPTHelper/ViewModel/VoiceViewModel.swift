//
//  VoiceViewModel.swift
//  GPTHelper
//
//  Created by DonHalab on 07.01.2024.
//

import AVFoundation
import Foundation
import OpenAI

class VoiceViewModel {
    var gptChatModel = GptViewModel()
    var audioPlayer: AVAudioPlayer?

    func voice(_ messages: String, retries: Int = 3, delay: TimeInterval = 2.0) async {
        let query = AudioSpeechQuery(model: .tts_1, input: messages, voice: .nova, responseFormat: .mp3, speed: 1.0)

        do {
            let res = try await openAI.audioCreateSpeech(query: query)
            audioPlayer = try AVAudioPlayer(data: res.audioData!)
            audioPlayer?.volume = 1.0
            audioPlayer?.play()
        } catch {
            print("Ошибка запроса: \(error). Оставшиеся попытки: \(retries)")
            if retries > 0 {
                do {
                    try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                    await voice(messages, retries: retries - 1, delay: delay * 2)
                } catch {
                    print("ERROR")
                }
            } else {
                print("Не удалось выполнить запрос.")
            }
        }
    }

    func voiceConvert(data: Data) async -> String {
        let query = AudioTranscriptionQuery(file: data, fileName: "voiceRecording.m4a", model: .whisper_1)

        do {
            let result = try await openAI.audioTranscriptions(query: query)
            return result.text
        } catch {
            print("Error \(error)")
        }
        return "Мое имя Анатолий"
    }
}
