//
//  UserListViewController.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 4.03.2025.
//

import UIKit

/// Kullanıcı listesini yöneten ViewController.
/// - Kullanıcı listesini ViewModel’den alır.
/// - Kullanıcı seçildiğinde detay sayfasına yönlendirir.
/// - Hata ve yükleme durumlarını yönetir.
class UserListViewController: UIViewController {
    weak var coordinator: AppCoordinator?  // Navigasyon işlemleri için Coordinator kullanıyoruz.
    private let userListView = UserListView() // Kullanıcı listesini gösteren UI bileşeni.
    private let viewModel = UserListViewModel() // Veriyi yöneten ViewModel.

    /// ViewController’ın ana View'ini `UserListView` olarak ayarlıyoruz.
    override func loadView() {
        view = userListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        setupBinding() // ViewModel ile bağlanıyoruz.
        viewModel.fetchUsers() // Kullanıcı listesini çekiyoruz.
        setupTableView() 
    }
    
    private func setupTableView() {
        userListView.tableView.delegate = self
        userListView.tableView.dataSource = self
    }
    
    /// ViewModel’den gelen güncellemelere tepki veriyoruz.
    private func setupBinding() {
        viewModel.onUsersUpdated = { [weak self] in
            self?.userListView.tableView.reloadData() // Yeni verileri UI’a yansıtıyoruz.
        }

        viewModel.onError = { [weak self] errorMessage in
            self?.showErrorAlert(message: errorMessage) // Hata mesajını gösteriyoruz.
        }
        
        viewModel.onLoadingStateChanged = { [weak self] isLoading in
            self?.handleLoadingState(isLoading) // Yükleme durumunu yönetiyoruz.
        }
    }
    
    /// Kullanıcının API çağrısı sırasında yükleme göstergesi görmesini sağlıyoruz.
    private func handleLoadingState(_ isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.userListView.activityIndicator.startAnimating()
            } else {
                self.userListView.activityIndicator.stopAnimating()
            }
        }
    }
    
    /// Hata mesajlarını UIAlertController ile kullanıcıya gösteriyoruz.
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}

// TableView için Delegate ve DataSource fonksiyonları.
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    /// Kullanıcı sayısı kadar satır oluşturuyoruz.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    /// Kullanıcı verisini her hücreye aktarıyoruz.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let user = viewModel.users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    /// Kullanıcı bir satıra tıkladığında detay ekranına yönlendiriyoruz.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.row]
        coordinator?.showUserDetail(user: user) // Coordinator üzerinden yönlendirme yapıyoruz.
    }
}
