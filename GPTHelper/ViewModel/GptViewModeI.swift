//
//  GptViewModeI.swift
//  GPTHelper
//
//  Created by DonHalab on 29.12.2023.
//

import Foundation

// MARK: - Для установки зависимости в Swift Package Manager  https://github.com/MacPaw/OpenAI.git

import OpenAI

// MARK: - Оснаная работа с API

class GptViewModel {

    var onReceiveStreamMessage: ((String) -> Void)?
    var onStreamProcessingCompleted: (() -> Void)?
    var streamTmp = ""
    var streamMass: [streamMessages] = []
    var index = 0
    var voiceComplite: (() -> Void)?

    // MARK: - Работа с текстом

    func sendMessage(_ message: String) async {
        
        messages.append(Chat(role: .user, content: message))
        streamMass.append(streamMessages(message: messages[index].content ?? "ошибка", role: .user))
        index += 1

        let query = ChatQuery(model: .gpt4_1106_preview, messages: messages)

        do {
            streamTmp = ""
            streamMass.append(streamMessages(message: streamTmp, role: .system))
            for try await result in openAI.chatsStream(query: query) {
                let responseString = result.choices.compactMap { $0.delta.content }
                    .joined(separator: "\n")
                streamTmp += responseString
                streamMass[index].message = streamTmp
                await streamCompite(responseString)
            }
            index += 1
            messages.append(Chat(role: .system, content: streamTmp))
            await updateUIAfterStreamCompleted()
        } catch {
            print("Ошибка: \(error)")
        }
    }

    // MARK: - Ожидание вывода сообщения, чтобы можно было блокировать кнопку отправки

    @MainActor private func updateUIAfterStreamCompleted() async {
        onStreamProcessingCompleted?()
    }

    // MARK: - Сриминговая передача

    @MainActor private func streamCompite(_ str: String) async {
        onReceiveStreamMessage?(str)
    }
}
