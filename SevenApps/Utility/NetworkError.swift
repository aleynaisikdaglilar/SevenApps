//
//  NetworkError.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 5.03.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case requestFailed(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Geçersiz URL, lütfen daha sonra tekrar deneyin."
        case .noData:
            return "Sunucudan veri alınamadı. Lütfen internet bağlantınızı kontrol edin."
        case .decodingError(let error):
            return "Veri çözümlenirken bir hata oluştu: \(error.localizedDescription)"
        case .requestFailed(let error):
            return "Bağlantı hatası: \(error.localizedDescription)"
        }
    }
}

