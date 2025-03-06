//
//  UserListView.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 5.03.2025.
//

import UIKit

// Kullanıcı listesini göstermek için kullanılan ana View.
protocol UserListViewDelegate: AnyObject {
    func didSelectUser(_ user: User)
}

class UserListView: UIView {
    weak var delegate: UserListViewDelegate?  // Kullanıcı tıklamalarını iletmek için protokol
    
    var users: [User] = [] {  // Kullanıcı verisini burada tutuyoruz.
        didSet {
            tableView.reloadData()  // Yeni veri geldiğinde TableView’i güncelliyoruz.
        }
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.userCell)
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(tableView)
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension UserListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    /// Kullanıcı bir satıra tıkladığında ViewController’a haber veriyoruz.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectUser(users[indexPath.row])
    }
}
