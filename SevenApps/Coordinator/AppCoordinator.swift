//
//  AppCoordinator.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 5.03.2025.
//

import UIKit

/// Uygulamanın ana navigasyonunu yöneten koordinatör.
/// Tüm ekran geçişleri bu sınıf üzerinden yönetilir.
class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    /// `AppCoordinator` başlatılırken `UINavigationController` alınır.
    /// - Parameter navigationController: Uygulamanın ana navigasyonunu yöneten controller.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// Uygulamanın başlangıç ekranını belirler.
    func start() {
        let userListVC = UserListViewController()
        userListVC.coordinator = self  // ViewController’a Coordinator atıyoruz
        navigationController.pushViewController(userListVC, animated: true)
    }
    
    /// Kullanıcı detay ekranına yönlendirir.
    /// - Parameter user: Detayları gösterilecek kullanıcı.
    func showUserDetail(user: User) {
        let detailVC = UserDetailViewController(user: user)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
