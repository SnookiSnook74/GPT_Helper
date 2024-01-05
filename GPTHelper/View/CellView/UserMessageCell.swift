//
//  UserMessageCell.swift
//  GPTHelper
//
//  Created by DonHalab on 04.01.2024.
//

import UIKit

// MARK: - Ячейка пользователя

final class UserMessageCell: UITableViewCell {
    let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: "user")
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        backgroundColor = #colorLiteral(red: 0.9591619372, green: 0.9591619372, blue: 0.9591619372, alpha: 1)
        selectionStyle = .none
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with message: String) {
        messageLabel.text = message
    }
}

extension UserMessageCell {
    private func setupSubviews() {
        contentView.addSubview(messageLabel)
        contentView.addSubview(avatarImageView)

        NSLayoutConstraint.activate([
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
        ])

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -20),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: -10),
        ])
    }
}
