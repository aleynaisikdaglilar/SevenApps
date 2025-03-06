//
//  User.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 4.03.2025.
//

import Foundation

/// Kullanıcı verisini temsil eden model.
/// - `Equatable` eklenerek iki `User` nesnesinin eşit olup olmadığını test edebilmemizi sağlar.
struct User: Decodable, Equatable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    // `Equatable` protokolü için manuel eşitlik kontrolü ekleyelim.
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.username == rhs.username &&
        lhs.email == rhs.email &&
        lhs.address == rhs.address &&
        lhs.phone == rhs.phone &&
        lhs.website == rhs.website &&
        lhs.company == rhs.company
    }
}
