//
//  UserRepositoryTests.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 6.03.2025.
//

import XCTest
@testable import SevenApps

class UserRepositoryTests: XCTestCase {
    var repository: UserRepository!
    var mockService: MockUserService!

    override func setUp() {
        super.setUp()
        mockService = MockUserService()
        repository = UserRepository(service: mockService)
    }

    override func tearDown() {
        repository = nil
        mockService = nil
        super.tearDown()
    }

    /// Önbellekleme mekanizmasının çalıştığını test eder.
    func testCacheMechanism() {
        let expectation = XCTestExpectation(description: "Önbellek mekanizması test ediliyor")

        repository.getUsers { firstCallResult in
            switch firstCallResult {
            case .success(let firstUsers):
                XCTAssertFalse(firstUsers.isEmpty, "İlk API çağrısı sonucu boş olmamalı")

                // İkinci kez çağırdığımızda API yerine cache'den gelmeli
                self.repository.getUsers { secondCallResult in
                    switch secondCallResult {
                    case .success(let secondUsers):
                        XCTAssertEqual(firstUsers, secondUsers, "Önbellekteki veri API verisiyle aynı olmalı")
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail("Önbellekten veri getirme başarısız oldu: \(error)")
                    }
                }
            case .failure(let error):
                XCTFail("API çağrısı başarısız oldu: \(error)")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
