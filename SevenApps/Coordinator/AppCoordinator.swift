//
//  AppCoordinator.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 5.03.2025.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let userListVC = UserListViewController()
        userListVC.coordinator = self  // Controller'a coordinator veriyoruz
        navigationController.pushViewController(userListVC, animated: true)
    }
    
    func showUserDetail(user: User) {
        let detailVC = UserDetailViewController(user: user)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
