//
//  InputAreaView.swift
//  GPTHelper
//
//  Created by DonHalab on 02.01.2024.
//

import UIKit

// MARK: - Поле для ввода сообщений и отправки

final class InputAreaView: UIView {
    var onSendButtonTapped: ((String) -> Void)?

    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Сообщение..."
        textField.backgroundColor = #colorLiteral(red: 0.9249228835, green: 0.9498340487, blue: 0.9880509973, alpha: 1)
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()

    let sendButton: UIButton = {
        let sendButton = UIButton(type: .system)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        sendButton.setPreferredSymbolConfiguration(symbolConfig, forImageIn: .normal)
        sendButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        return sendButton
    }()

    // Установка действий
    private func setupActions() {
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }

    // Внутри InputAreaView
    @objc private func sendButtonTapped() {
        onSendButtonTapped?(textField.text ?? "")
        textField.text = ""
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
       setupConstraints()
    }

    private func setupViews() {
        backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
        addSubviews()
    }

    private func addSubviews() {
        addSubview(textField)
        addSubview(sendButton)
    }

   
}

extension InputAreaView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 280),
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
        ])

        NSLayoutConstraint.activate([
            sendButton.widthAnchor.constraint(equalToConstant: 44),
            sendButton.heightAnchor.constraint(equalToConstant: 44),
            sendButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 45),
        ])
    }
}
