//
//  ChatMessage.swift
//  GPTHelper
//
//  Created by DonHalab on 29.12.2023.
//

import Foundation

struct ChatMessage {
    enum Role {
        case user, system
    }

    let role: Role
    let content: String
}
