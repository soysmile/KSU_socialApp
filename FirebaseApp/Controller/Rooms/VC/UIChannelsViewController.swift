//
//  UIChannelsViewController.swift
//  FirebaseApp
//
//  Created by George Heints on 8/16/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class UIChannelsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func createTagMessage(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TagMessageViewController") as! TagMessageViewController
        let navController = UINavigationController(rootViewController: nextVC)
        self.present(navController, animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 55
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let channel = channels[indexPath.row]
        let vc = ChatViewController(user: currentUser, channel: channel)
        navigationController?.pushViewController(vc, animated: true)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return channels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: channelCellIdentifier, for: indexPath)

        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = .clear

        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = channels[indexPath.row].name
        cell.textLabel?.textColor = UIColor.white

        return cell
    }

    @IBAction func addRoom(_ sender: Any) {
        addButtonPressed()
    }
    @IBOutlet weak var tableViewChannels: UITableView!

    private let toolbarLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private let channelCellIdentifier = "channelCell"
    private var currentChannelAlertController: UIAlertController?
    private var tagVC = TagMessageViewController()

    private let db = Firestore.firestore()

    private var channelReference: CollectionReference {
        return db.collection("channels")
    }

    private var channels = [Channel]()
    private var channelListener: ListenerRegistration?

    private var currentUser: User = Auth.auth().currentUser!

    deinit {
        channelListener?.remove()
    }

    /*
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(style: .grouped)

        title = "Channels"
    }
    */

    private func setUpTableView() {
        self.tabBarController?.tabBar.isHidden = false
        definesPresentationContext = true
        tableViewChannels.delegate = self
        tableViewChannels.dataSource = self
        //tableViewChannels.addSubview(self.refreshControl)
        tableViewChannels.backgroundColor = .clear
        tableViewChannels.separatorColor = UIColor.black
        self.view.backgroundColor = UIColor(red: 24.0/255.0, green: 34.0/255.0, blue: 45.0/255.0, alpha: 1.0)
        tableViewChannels.register(UITableViewCell.self, forCellReuseIdentifier: channelCellIdentifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        self.title = "Комнаты"
        setUpTableView()
        //clearsSelectionOnViewWillAppear = true
        /*
        toolbarItems = [
            UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(customView: toolbarLabel),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed)),
        ]
        toolbarLabel.text = AppSettings.displayName
        */
        channelListener = channelReference.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }

            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isToolbarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.isToolbarHidden = true
    }

    // MARK: - Actions

    @objc private func signOut() {
        let ac = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            do {
                try Auth.auth().signOut()
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }))
        present(ac, animated: true, completion: nil)
    }

    @objc private func addButtonPressed() {
        let ac = UIAlertController(title: "Создать новую комнату", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        ac.addTextField { field in
            field.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            field.enablesReturnKeyAutomatically = true
            field.autocapitalizationType = .words
            field.clearButtonMode = .whileEditing
            field.placeholder = "Название комнаты"
            field.returnKeyType = .done
            field.tintColor = .primary
        }

        let createAction = UIAlertAction(title: "Создать", style: .default, handler: { _ in
            self.createChannel()
        })
        createAction.isEnabled = false
        ac.addAction(createAction)
        ac.preferredAction = createAction

        present(ac, animated: true) {
            ac.textFields?.first?.becomeFirstResponder()
        }
        currentChannelAlertController = ac
    }

    @objc private func textFieldDidChange(_ field: UITextField) {
        guard let ac = currentChannelAlertController else {
            return
        }

        ac.preferredAction?.isEnabled = field.hasText
    }

    // MARK: - Helpers
    private func createChannel() {
        guard let ac = currentChannelAlertController else {
            return
        }

        guard let channelName = ac.textFields?.first?.text else {
            return
        }

        //Create chanell
        let channel = Channel(name: channelName)
        channelReference.addDocument(data: channel.representation) { error in
            if let e = error {
                print("Error saving channel: \(e.localizedDescription)")
            }
        }
    }

    private func addChannelToTable(_ channel: Channel) {
        guard !channels.contains(channel) else {
            return
        }

        channels.append(channel)
        channels.sort()

        guard let index = channels.index(of: channel) else {
            return
        }
        tableViewChannels.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    private func updateChannelInTable(_ channel: Channel) {
        guard let index = channels.index(of: channel) else {
            return
        }

        channels[index] = channel
        tableViewChannels.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    private func removeChannelFromTable(_ channel: Channel) {
        guard let index = channels.index(of: channel) else {
            return
        }

        channels.remove(at: index)
        tableViewChannels.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    private func handleDocumentChange(_ change: DocumentChange) {
        guard let channel = Channel(document: change.document) else {
            return
        }

        switch change.type {
        case .added:
            addChannelToTable(channel)

        case .modified:
            updateChannelInTable(channel)

        case .removed:
            removeChannelFromTable(channel)
        }
    }

}

