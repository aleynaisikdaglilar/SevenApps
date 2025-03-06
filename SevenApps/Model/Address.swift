//
//  Address.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 5.03.2025.
//

import Foundation

struct Address: Decodable, Equatable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}
