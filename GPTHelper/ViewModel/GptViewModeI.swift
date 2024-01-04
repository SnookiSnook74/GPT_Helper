//
//  GptViewModeI.swift
//  GPTHelper
//
//  Created by DonHalab on 29.12.2023.
//

import Foundation
import OpenAI

class GptViewModel {
    var messages: [Chat] = []
    private let openAI = OpenAI(apiToken: "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")

    var onReceiveStreamMessage: ((String) -> Void)?
    var streamTmp = ""
    var streamMass = [String]()
    var index = 0


    func sendMessage(_ message: String) async {
        messages.append(Chat(role: .user, content: message))
        streamMass.append(messages[index].content ?? "ошибка")
        index += 1

        let query = ChatQuery(model: .gpt4_1106_preview, messages: messages)

        do {
            streamTmp = ""
            streamMass.append(streamTmp)
            for try await result in openAI.chatsStream(query: query) {
                let responseString = result.choices.compactMap { $0.delta.content }
                    .joined(separator: "\n")
                streamTmp += responseString
                streamMass[index] = streamTmp
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
