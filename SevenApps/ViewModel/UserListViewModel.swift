//
//  UserListViewModel.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 4.03.2025.
//

import Foundation

/// Kullanıcı listesini yöneten ViewModel.
/// ViewController ile Model katmanı arasında köprü görevi görür.
/// Repository'den veriyi alır, işler ve UI'a uygun hale getirerek ViewController'a iletir.
class UserListViewModel {
    private let repository: UserRepositoryProtocol  // Kullanıcı verilerini yöneten Repository
    var users: [User] = []  // Kullanıcı listesini saklayan dizi
    
    /// Kullanıcı verileri güncellendiğinde ViewController'ı bilgilendiren callback fonksiyonu.
    var onUsersUpdated: (() -> Void)?
    
    /// Hata oluştuğunda ViewController'a hata mesajını ileten callback fonksiyonu.
    var onError: ((String) -> Void)?
    
    /// Yükleme durumu değiştiğinde ViewController'a bilgi veren callback fonksiyonu.
    var onLoadingStateChanged: ((Bool) -> Void)?
    
    /// Repository bağımlılığı dışarıdan enjekte edilir.
    /// Bu sayede bağımlılığı test edebilir hale getirmiş oluruz.
    /// - Parameter repository: Kullanıcı verilerini yöneten repository.
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    /// Kullanıcı listesini getirir.
    /// - API çağrısı başladığında loading göstergesi aktif edilir.
    /// - API cevabı geldiğinde loading durdurulur ve sonuç işlenir.
    func fetchUsers() {
        onLoadingStateChanged?(true)  // API çağrısı başlamadan önce loading göster
        
        repository.getUsers { [weak self] result in
            DispatchQueue.main.async {
                self?.onLoadingStateChanged?(false)  // API cevabı geldikten sonra loading kapat
                
                switch result {
                case .success(let users):
                    self?.users = users
                    self?.onUsersUpdated?()  // UI güncellenmesi için callback çalıştır
                case .failure(let error):
                    self?.onError?(error.getMessage())  // Hata mesajını UI'a ilet
                }
            }
        }
    }
}
