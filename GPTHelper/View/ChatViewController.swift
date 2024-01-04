//
//  ChatViewController.swift
//  GPTHelper
//
//  Created by DonHalab on 29.12.2023.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource {

    let gptModel = GptViewModel()

    var inputAreaView: InputAreaView = {
        let inputAreaView = InputAreaView()
        inputAreaView.translatesAutoresizingMaskIntoConstraints = false
        return inputAreaView
    }()

    var chatTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setupConstraints()
        setupView()
        startDialogue()

        chatTableView.dataSource = self
        chatTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9598327279, green: 0.9598327279, blue: 0.9598327279, alpha: 1)
        title = "GPT"
    }

    func addSubView() {
        view.addSubview(chatTableView)
        view.addSubview(inputAreaView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: inputAreaView.topAnchor),

            inputAreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            inputAreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            inputAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            inputAreaView.heightAnchor.constraint(equalToConstant: 70),
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gptModel.streamMass.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = UIListContentConfiguration.cell()
        config.text = gptModel.streamMass[indexPath.row]
        cell.contentConfiguration = config
        return cell
    }

    func startDialogue() {
        inputAreaView.onSendButtonTapped = { [weak self] text in
            Task {
                await self?.gptModel.sendMessage(text)
                self?.chatTableView.reloadData()
            }
        }

        gptModel.onReceiveStreamMessage = { [weak self] test in
            DispatchQueue.main.async {
                self?.chatTableView.reloadData()
                }
            }
        }

    }


