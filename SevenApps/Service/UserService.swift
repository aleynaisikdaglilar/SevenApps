//
//  UserService.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 4.03.2025.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

class UserService: UserServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        let fakeError = Bool.random()  // %50 ihtimalle hata döndür
        if fakeError {
            completion(.failure(.requestFailed(NSError(domain: "", code: -1009, userInfo: [NSLocalizedDescriptionKey: "İnternet bağlantınız yok."]))))
            return
        }
        request(endpoint: APIConstants.usersURL, completion: completion)
    }
    
    private func request<T: Decodable>(endpoint: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}
