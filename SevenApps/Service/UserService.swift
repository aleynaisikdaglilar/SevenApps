//
//  UserService.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 4.03.2025.
//

import Foundation

/// Kullanıcılarla ilgili API işlemlerini gerçekleştiren servis protokolü.
/// `UserService` sınıfını test edebilmek için bağımlılığı gevşetmek amacıyla kullanılır.
protocol UserServiceProtocol {
    /// Kullanıcı listesini API'den çeker.
    /// - Parameter completion: Başarı durumunda `User` dizisi, hata durumunda `NetworkError`
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

/// Kullanıcı verilerini almak için kullanılan servis.
/// Bu sınıf, `NetworkService` üzerinden API'ye istek yapar.
class UserService: UserServiceProtocol {
    private let networkService: NetworkServiceProtocol

    /// `NetworkService` bağımlılığını dışarıdan alarak bağımsız hale getiriyoruz.
    /// Böylece farklı `NetworkService` implementasyonları ile test edilebilir.
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    /// Kullanıcı listesini API'den getirir.
    /// - Parameter completion: Başarı durumunda `User` dizisi, hata durumunda `NetworkError`
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        networkService.request(route: .fetchUsers, method: .get, parameters: nil, completion: completion)
    }
}
