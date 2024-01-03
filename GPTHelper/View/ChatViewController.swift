//
//  ChatViewController.swift
//  GPTHelper
//
//  Created by DonHalab on 29.12.2023.
//

import UIKit

class ChatViewController: UIViewController {
    let gptModel = GptViewModel()

    var inputAreaView: InputAreaView = {
        let inputAreaView = InputAreaView()
        inputAreaView.translatesAutoresizingMaskIntoConstraints = false
        return inputAreaView
    }()

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
        addSubView()
        setupConstraints()
        setupView()
        startDialogue()
    }

    func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9598327279, green: 0.9598327279, blue: 0.9598327279, alpha: 1)
        title = "GPT"
    }
}

extension ChatViewController {
    func startDialogue() {
        inputAreaView.onSendButtonTapped = { text in
            self.answerGPT.text = ""
            Task {
                await self.gptModel.sendMessage(text)
            }
        }

        gptModel.onReceiveStreamMessage = { [weak self] message in
            DispatchQueue.main.async {
                self?.answerGPT.text = (self?.answerGPT.text ?? "") + message
            }
        }
    }
}

extension ChatViewController {
    func addSubView() {
        view.addSubview(answerGPT)
        view.addSubview(inputAreaView)
    }
}

extension ChatViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            answerGPT.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerGPT.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            answerGPT.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerGPT.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            inputAreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            inputAreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            inputAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            inputAreaView.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
}
