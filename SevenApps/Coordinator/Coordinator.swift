//
//  Coordinator.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 5.03.2025.
//

import UIKit

/// Navigation Katmanının Amacı:
/// ViewController'ların doğrudan birbirine bağımlı olmasını önler.
/// Tüm navigasyon işlemleri merkezi bir noktadan (Coordinator) yönetilir.
/// Böylece ViewController’lar yalnızca işlevlerine odaklanır, hangi ekrana nasıl gidileceğini bilmek zorunda kalmaz.
/// Uygulama ölçeklenebilir hale gelir ve yeni ekran eklemek çok kolay olur.

/// Tüm Coordinator'ların uygulaması gereken temel protokol.
/// - `navigationController`: Navigasyonun yönetildiği `UINavigationController`
/// - `start()`: Coordinator’ın başlangıç fonksiyonu.
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    /// Koordinatörün başlatılması için gerekli metot.
    func start()
}

