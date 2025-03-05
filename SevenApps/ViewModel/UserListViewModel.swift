//
//  UserListViewModel.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 4.03.2025.
//

import Foundation

class UserListViewModel {
    private let repository: UserRepositoryProtocol
    var users: [User] = []
    var onUsersUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?  // Yeni loading callback
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    func fetchUsers() {
        onLoadingStateChanged?(true)  // API çağrısı başlarken loading başlasın
        
        repository.getUsers { [weak self] result in
            DispatchQueue.main.async {
                self?.onLoadingStateChanged?(false)  // API çağrısı bitince loading dursun
                
                switch result {
                case .success(let users):
                    self?.handleSuccess(users)
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        }
    }
    
    private func handleSuccess(_ users: [User]) {
        self.users = users
        self.onUsersUpdated?()
    }
    
    private func handleError(_ error: NetworkError) {
        onError?(error.localizedDescription)  // UI'ya düzgün hata mesajı ilet
    }
}
