//
//  UserRepository.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 4.03.2025.
//

import Foundation

/// Kullanıcı verilerini yöneten repository protokolü.
/// Bu yapı sayesinde `UserRepository` sınıfı, farklı veri kaynaklarından (API, veritabanı vs.) veri getirebilir.
protocol UserRepositoryProtocol {
    /// Kullanıcı listesini getirir.
    /// - Parameter completion: Başarı durumunda `User` dizisi, hata durumunda `NetworkError`
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

/// Kullanıcı verilerini yönetmek için `Repository Pattern` uygulanmıştır.
/// `UserRepository`, API'den veri almak için `UserService` kullanır.
/// Aynı zamanda, daha verimli çalışması için `cache` mekanizması uygular.
class UserRepository: UserRepositoryProtocol {
    private let service: UserServiceProtocol
    private var cachedUsers: [User]?  // Önbelleğe alınmış kullanıcı verisi
    
    /// `UserService` bağımlılığını dışarıdan alarak test edilebilir bir yapı oluşturuyoruz.
    /// - Parameter service: Kullanıcı verisini API’den çeken servis.
    init(service: UserServiceProtocol = UserService()) {
        self.service = service
    }
    
    /// Kullanıcı listesini getirir. Öncelikle önbellekten kontrol eder, yoksa API çağrısı yapar.
    /// - Parameter completion: Kullanıcı listesini veya hata durumunu döndürür.
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        // Eğer önbellekte kullanıcılar varsa, doğrudan döndür.
        if let cachedUsers = cachedUsers {
            completion(.success(cachedUsers))
            return
        }
        
        // API çağrısı yap
        service.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.cachedUsers = users  // Kullanıcıları önbelleğe kaydet
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
