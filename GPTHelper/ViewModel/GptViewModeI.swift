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

    func sendMessage(_ message: String) async {
        messages.append(Chat(role: .user, content: message))

        let query = ChatQuery(model: .gpt4_1106_preview, messages: messages)
        
        var tmp = ""

        do {
            for try await result in openAI.chatsStream(query: query) {
                let responseString = result.choices.compactMap { $0.delta.content }
                    .joined(separator: "\n")
                tmp += responseString

                DispatchQueue.main.async {
                    self.onReceiveStreamMessage?(responseString)
                }
            }
            messages.append(Chat(role: .system, content: tmp))
        } catch {
            print("Ошибка: \(error)")
        }
    }

}
