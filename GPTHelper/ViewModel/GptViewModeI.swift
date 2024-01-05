//
//  GptViewModeI.swift
//  GPTHelper
//
//  Created by DonHalab on 29.12.2023.
//

import Foundation
import OpenAI

//MARK: - Оснаная работа с API 

class GptViewModel {
    var messages: [Chat] = []
    private let openAI = OpenAI(apiToken: "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")

    var onReceiveStreamMessage: ((String) -> Void)?
    var streamTmp = ""
    var streamMass = [streamMessages]()
    var index = 0

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
                DispatchQueue.main.async {
                    self.onReceiveStreamMessage?(responseString)
                }
            }
            index += 1
            messages.append(Chat(role: .system, content: streamTmp))
        } catch {
            print("Ошибка: \(error)")
        }
    }
}
