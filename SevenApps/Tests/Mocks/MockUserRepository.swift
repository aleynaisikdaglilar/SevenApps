//
//  MockUserRepository.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 6.03.2025.
//

import Foundation
@testable import SevenApps

/// Gerçek API çağrısı yapmadan test etmek için kullanılan sahte repository (Mock Repository).
class MockUserRepository: UserRepositoryProtocol {
    /// Test için kullanılacak sahte kullanıcı listesi.
    let mockUsers: [User] = [
        User(id: 1, name: "Test User 1", username: "testuser1", email: "test1@example.com",
             address: Address(street: "Street 1", suite: "Apt. 1", city: "City 1", zipcode: "12345"),
             phone: "123-456-7890", website: "test1.com",
             company: Company(name: "Company 1", catchPhrase: "Catchphrase 1", bs: "Business 1")),
        
        User(id: 2, name: "Test User 2", username: "testuser2", email: "test2@example.com",
             address: Address(street: "Street 2", suite: "Apt. 2", city: "City 2", zipcode: "67890"),
             phone: "987-654-3210", website: "test2.com",
             company: Company(name: "Company 2", catchPhrase: "Catchphrase 2", bs: "Business 2"))
    ]
    
    /// Gerçek API çağrısı yapmadan test için sahte kullanıcıları döndürür.
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        completion(.success(mockUsers))
    }
}

