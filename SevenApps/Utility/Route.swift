//
//  Route.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 6.03.2025.
//

import Foundation

// API endpoint'lerini merkezi olarak yöneten yapı.
// API URL'lerini her yerde manuel olarak yazmak yerine burada yöneterek hata yapma riskini azaltıyoruz.
enum Route {
    // API'nin ana URL adresi
    static let baseUrl = "https://jsonplaceholder.typicode.com"
    
    // Kullanıcı listesini getiren endpoint
    case fetchUsers
    
    // Seçilen endpoint'e göre tam URL'i döndürür.
    var urlString: String {
        switch self {
        case .fetchUsers:
            return "\(Route.baseUrl)/users"
        }
    }
}

