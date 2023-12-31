//
//  ChatViewController.swift
//  GPTHelper
//
//  Created by DonHalab on 29.12.2023.
//

import UIKit

class ChatViewController: UIViewController {
    let gptModel = GptViewModel()

    var answerGPT: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 22)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.textColor = .black
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        view.backgroundColor = .orange
        startDilogue()
    }
}

extension ChatViewController {
    func startDilogue() {
        Task {
            await gptModel.sendMessage("Привет! что ты умеешь?")
        }

        gptModel.onReceiveStreamMessage = { [weak self] message in
            DispatchQueue.main.async {
                self?.answerGPT.text = (self?.answerGPT.text ?? "") + message
            }
        }
    }
}

extension ChatViewController {
    func setupView() {
        view.addSubview(answerGPT)
    }
}

extension ChatViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            answerGPT.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerGPT.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            answerGPT.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerGPT.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
        ])
    }
}
