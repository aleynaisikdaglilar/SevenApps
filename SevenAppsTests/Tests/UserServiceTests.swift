//
//  UserServiceTests.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 6.03.2025.
//

import XCTest
@testable import SevenApps  

class UserServiceTests: XCTestCase {
    var userService: UserService!
    
    override func setUp() {
        super.setUp()
        userService = UserService()
    }

    override func tearDown() {
        userService = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() {
        let expectation = XCTestExpectation(description: "API başarıyla veri getirdi")
        
        userService.fetchUsers { result in
            switch result {
            case .success(let users):
                XCTAssertFalse(users.isEmpty, "Kullanıcı listesi boş olmamalı")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("API çağrısı başarısız oldu: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)  
    }
}
