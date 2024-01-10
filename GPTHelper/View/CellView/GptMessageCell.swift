//
//  GptMessageCell.swift
//  GPTHelper
//
//  Created by DonHalab on 04.01.2024.
//

import UIKit

// MARK: - Ячека ответа бота

final class GptMessageCell: UITableViewCell {
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 30)
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .all
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "gpt")
        return imageView
    }()

    func configure(with message: NSAttributedString) {
        messageTextView.attributedText = message
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.9591619372, green: 0.9591619372, blue: 0.9591619372, alpha: 1)
        selectionStyle = .none
        setupSubviews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GptMessageCell {
    private func setupSubviews() {
        contentView.addSubview(messageTextView)
        contentView.addSubview(avatarImageView)

        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
        ])

        NSLayoutConstraint.activate([
            messageTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            messageTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            messageTextView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: -5),
            messageTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])

        avatarImageView.layer.cornerRadius = 30
    }
}
