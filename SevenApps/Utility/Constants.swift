//
//  Constants.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 5.03.2025.
//

import UIKit

struct APIConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    static let usersEndpoint = "/users"
    
    static var usersURL: String {
        return baseURL + usersEndpoint
    }
}

struct UIConstants {
    static let padding: CGFloat = 20
    static let cornerRadius: CGFloat = 10
    static let labelFontSize: CGFloat = 16
}

struct CellIdentifiers {
    static let userCell = "UserTableViewCell"
}

