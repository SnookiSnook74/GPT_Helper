//
//  save.swift
//  GPTHelper
//
//  Created by DonHalab on 05.01.2024.
//

// import UIKit
//
//// MARK: - Основой контроллер для поля чата
//
// class ChatViewController: UIViewController {
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
//        table.separatorStyle = .none
//        table.translatesAutoresizingMaskIntoConstraints = false
//        table.backgroundColor = #colorLiteral(red: 0.9591619372, green: 0.9591619372, blue: 0.9591619372, alpha: 1)
//        return table
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addSubView()
//        setupConstraints()
//        setupView()
//        startDialogue()
//        setupTable()
//        setupNotifacation()
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
// }
//
//// MARK: - Основная логика вывода стримига в таблицу
//
// extension ChatViewController {
//    func startDialogue() {
//        inputAreaView.onSendButtonTapped = { [weak self] text in
//            // Блокировка кнопки отправки сообщения до полного вывода сообщения
//            self?.inputAreaView.setSendButtonEnabled(false)
//
//            Task {
//                await self?.gptModel.sendMessage(text)
//                self?.chatTableView.reloadData()
//            }
//        }
//
//        gptModel.onReceiveStreamMessage = { [weak self] _ in
//            self?.chatTableView.reloadData()
//        }
//        gptModel.onStreamProcessingCompleted = { [weak self] in
//            self?.inputAreaView.setSendButtonEnabled(true)
//        }
//    }
// }
//
//// MARK: - Настройки View
//
// extension ChatViewController {
//    func addSubView() {
//        view.addSubview(chatTableView)
//        view.addSubview(inputAreaView)
//    }
//
//    func setupView() {
//        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        title = "GPT"
//    }
//
//    func setupTable() {
//        chatTableView.dataSource = self
//        chatTableView.register(GptMessageCell.self, forCellReuseIdentifier: "gpt")
//        chatTableView.register(UserMessageCell.self, forCellReuseIdentifier: "user")
//    }
// }
//
//// MARK: - Работа с таблицей
//
// extension ChatViewController: UITableViewDataSource {
//    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
//        return gptModel.streamMass.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if gptModel.streamMass[indexPath.row].role == .system {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "gpt", for: indexPath) as! GptMessageCell
//            cell.configure(with: gptModel.streamMass[indexPath.row].message)
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! UserMessageCell
//            cell.configure(with: gptModel.streamMass[indexPath.row].message)
//            return cell
//        }
//    }
// }
//
//// MARK: - Работа с клавиатурой
//
// extension ChatViewController {
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            inputAreaView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + 15)
//        }
//    }
//
//    @objc func keyboardWillHide(notification _: NSNotification) {
//        // Возвращаем inputAreaView на исходное место
//        inputAreaView.transform = .identity
//    }
// }
//
// extension ChatViewController {
//    func setupNotifacation() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
// }
//
//// MARK: - Констрейнты для View
//
// extension ChatViewController {
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
// }
//
