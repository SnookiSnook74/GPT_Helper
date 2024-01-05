//
//  ChatMessage.swift
//  GPTHelper
//
//  Created by DonHalab on 29.12.2023.
//

import Foundation
import OpenAI

// MARK: - Модель для хранения стриминовых ответов

struct streamMessages {
    var message: String
    var role: Chat.Role
}
