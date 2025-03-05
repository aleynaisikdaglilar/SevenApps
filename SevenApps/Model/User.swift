//
//  User.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 4.03.2025.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
}

