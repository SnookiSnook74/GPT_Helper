//
//  test.swift
//  GPTHelper
//
//  Created by DonHalab on 03.01.2024.
//

//import Foundation
//
//
//import UIKit
//
//class ChatViewController: UIViewController, UITableViewDataSource {
//
//    let gptModel = GptViewModel()
//
//    var inputAreaView: InputAreaView = {
//        let inputAreaView = InputAreaView()
//        inputAreaView.translatesAutoresizingMaskIntoConstraints = false
//        return inputAreaView
//    }()
//
//    var chatTableView: UITableView = {
//        let table = UITableView()
//        table.translatesAutoresizingMaskIntoConstraints = false
//        return table
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addSubView()
//        setupConstraints()
//        setupView()
//        startDialogue()
//        
//        chatTableView.dataSource = self
//        chatTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    }
//
//    func setupView() {
//        view.backgroundColor = #colorLiteral(red: 0.9598327279, green: 0.9598327279, blue: 0.9598327279, alpha: 1)
//        title = "GPT"
//    }
//
//    func addSubView() {
//        view.addSubview(chatTableView)
//        view.addSubview(inputAreaView)
//    }
//
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            chatTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            chatTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            chatTableView.bottomAnchor.constraint(equalTo: inputAreaView.topAnchor),
//
//            inputAreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            inputAreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            inputAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            inputAreaView.heightAnchor.constraint(equalToConstant: 70),
//        ])
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return gptModel.messages.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.numberOfLines = 0
//        let message = gptModel.messages[indexPath.row]
//        cell.textLabel?.text = message.content
//        return cell
//    }
//
//    func startDialogue() {
//        inputAreaView.onSendButtonTapped = { [weak self] text in
//            Task {
//                await self?.gptModel.sendMessage(text)
//            }
//        }
//
//        gptModel.onReceiveStreamMessage = { [weak self] _ in
//            DispatchQueue.main.async {
//                self?.chatTableView.reloadData()
//            }
//        }
//    }
//}
//
