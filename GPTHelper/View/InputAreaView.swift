//
//  InputAreaView.swift
//  GPTHelper
//
//  Created by DonHalab on 02.01.2024.
//

import UIKit

class InputAreaView: UIView {
    let textField = UITextField()
    let sendButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        textField.borderStyle = .roundedRect
        sendButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        
        addSubview(textField)
        addSubview(sendButton)
    }
    
    private func setupConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Ограничения для textField
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        // Ограничения для sendButton
        NSLayoutConstraint.activate([
            sendButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            sendButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 44), // Пример ширины кнопки
            sendButton.heightAnchor.constraint(equalTo: sendButton.widthAnchor) // Высота равна ширине для круглой кнопки
        ])
        
        // Ограничение, чтобы кнопка не перекрывала текстовое поле
        textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8).isActive = true
    }

}
