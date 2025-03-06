//
//  NetworkError.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 5.03.2025.
//

import Foundation

// API çağrılarında karşılaşılabilecek olası hata durumları
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case requestFailed(Error)

    func getMessage() -> String {
        switch self {
        case .invalidURL:
            return "Geçersiz URL, lütfen daha sonra tekrar deneyin."
        case .noData:
            return "Sunucudan veri alınamadı. Lütfen internet bağlantınızı kontrol edin."
        case .decodingError:
            return "Veri çözümlenirken bir hata oluştu."
        case .requestFailed:
            return "Bağlantı hatası, lütfen internet bağlantınızı kontrol edin."
        }
    }
}
