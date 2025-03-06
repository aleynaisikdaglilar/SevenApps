//
//  ErrorManager.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 6.03.2025.
//

import Foundation

class ErrorManager {
    static func handle(error: Error) -> String {
        if let networkError = error as? NetworkError {
            return networkError.getMessage()
        }
        return "Bilinmeyen bir hata oluştu."
    }
}
