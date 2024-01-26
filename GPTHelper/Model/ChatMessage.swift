//
//  ChatMessage.swift
//  GPTHelper
//
//  Created by DonHalab on 29.12.2023.
//

import Foundation
import OpenAI

let openAI = OpenAI(apiToken: "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")

// MARK: - Модель для хранения стриминовых ответов

struct streamMessages {
    var message: String
    var role: Chat.Role
}

var indexCount = 2

var messages: [Chat] = [Chat(role: .user, content: "Ты будешь моим персональным помощником. Меня зовут Анатолий Гарриевич, обращайся ко мне всегда по имени и отчеству. Абсолютно всегда! Не забывай про это!"),
                        Chat(role: .system, content: "Хорошо Анатолий Гарриевич! Чем могу быть полезен")]
