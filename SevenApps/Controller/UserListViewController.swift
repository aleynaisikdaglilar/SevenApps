//
//  UserListViewController.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 4.03.2025.
//

import UIKit

class UserListViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    private let userListView = UserListView()
    private let viewModel = UserListViewModel()
    
    override func loadView() {
        view = userListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        setupBinding()
        viewModel.fetchUsers()
        setupTableView()
    }
    
    private func setupTableView() {
        userListView.tableView.delegate = self
        userListView.tableView.dataSource = self
    }
    
    private func setupBinding() {
        viewModel.onUsersUpdated = { [weak self] in
            self?.userListView.tableView.reloadData()
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.showErrorAlert(message: errorMessage)
        }
        
        viewModel.onLoadingStateChanged = { [weak self] isLoading in
            self?.handleLoadingState(isLoading)
        }
    }
    
    private func handleLoadingState(_ isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.userListView.activityIndicator.startAnimating()
            } else {
                self.userListView.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let user = viewModel.users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.row]
        coordinator?.showUserDetail(user: user)
    }
}
