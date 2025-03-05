//
//  Coordinator.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 5.03.2025.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

