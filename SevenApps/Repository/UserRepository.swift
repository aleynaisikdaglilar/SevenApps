//
//  UserRepository.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 4.03.2025.
//

import Foundation

protocol UserRepositoryProtocol {
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

class UserRepository: UserRepositoryProtocol {
    private let service: UserServiceProtocol
    private var cachedUsers: [User]?
    
    init(service: UserServiceProtocol = UserService()) {
        self.service = service
    }
    
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        if let cachedUsers = cachedUsers {
            completion(.success(cachedUsers))
            return
        }
        
        service.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.cachedUsers = users  // Cache ekledik
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
