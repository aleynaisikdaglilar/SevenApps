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
class UserListViewController: UIViewController, UserListViewDelegate {
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
        userListView.delegate = self // Kullanıcı seçimlerini almak için delegasyonu atıyoruz.
        setupBinding() // ViewModel ile bağlanıyoruz.
        viewModel.fetchUsers() // Kullanıcı listesini çekiyoruz.
    }
    
    /// ViewModel’den gelen güncellemelere tepki veriyoruz.
    private func setupBinding() {
        viewModel.onUsersUpdated = { [weak self] in
            self?.userListView.users = self?.viewModel.users ?? []  // Kullanıcı listesini UI’a yansıtıyoruz.
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
    
    /// Kullanıcı bir satıra tıkladığında detay ekranına yönlendiriyoruz.
    func didSelectUser(_ user: User) {
        coordinator?.showUserDetail(user: user) // Coordinator üzerinden yönlendirme yapıyoruz.
    }
}

