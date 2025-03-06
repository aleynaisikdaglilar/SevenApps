//
//  NetworkService.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 6.03.2025.
//

import Foundation

/// API çağrılarını merkezi bir noktadan yönetmek için kullanılan servis protokolü.
/// Bu yapı sayesinde tüm ağ istekleri `request<T>()` metoduyla tek bir noktadan yapılır.
protocol NetworkServiceProtocol {
    /// Genel bir API isteği yapar ve sonucu tamamlayıcı bloğa döndürür.
    /// - Parameters:
    ///   - route: Çağrılacak API'nin endpoint'ini belirler (`Route` enum kullanarak)
    ///   - method: HTTP metodu (GET, POST vb.)
    ///   - parameters: Eğer gerekliyse, API'ye gönderilecek JSON formatındaki veriler
    ///   - completion: Başarı durumunda `T` tipinde bir nesne, hata durumunda `NetworkError`
    func request<T: Decodable>(route: Route, method: Method, parameters: [String: Any]?, completion: @escaping (Result<T, NetworkError>) -> Void)
}

/// Uygulamanın API ile iletişimini sağlayan servis.
/// Bu sınıf, tüm HTTP isteklerini `URLSession` kullanarak gerçekleştirir.
class NetworkService: NetworkServiceProtocol {
    /// Genel API çağrısını gerçekleştirir.
    func request<T: Decodable>(route: Route, method: Method, parameters: [String: Any]? = nil, completion: @escaping (Result<T, NetworkError>) -> Void) {
        // URL oluşturulamazsa, hata döndürülür.
        guard let url = URL(string: route.urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Eğer API'ye parametre göndermek gerekiyorsa, JSON formatında eklenir.
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        // API çağrısını başlatıyoruz.
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Eğer ağ hatası oluşursa, `requestFailed` hatası döndürülür.
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            // Eğer API'den dönen veri boşsa, hata döndürülür.
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase // Eğer API `snake_case` formatında dönerse.

            do {
                // JSON verisini `T` tipine çevir ve başarılı sonucu döndür.
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                // JSON çözümlenemezse, hata döndürülür.
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume() // API çağrısını başlat.
    }
}
