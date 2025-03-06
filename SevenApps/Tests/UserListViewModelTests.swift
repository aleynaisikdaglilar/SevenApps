//
//  UserListViewModelTests.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 6.03.2025.
//

import XCTest
@testable import SevenApps

/// `UserListViewModel` sınıfının birim testlerini içeren test sınıfı.
class UserListViewModelTests: XCTestCase {
    var viewModel: UserListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = UserListViewModel(repository: MockUserRepository())
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    /// Kullanıcı listesinin başarıyla alındığını test eder.
    func testFetchUsersSuccess() {
        let expectation = XCTestExpectation(description: "ViewModel kullanıcıları başarılı bir şekilde çekti")
        
        viewModel.onUsersUpdated = {
            XCTAssertFalse(self.viewModel.users.isEmpty, "ViewModel kullanıcı listesi boş olmamalı")
            expectation.fulfill()
        }
        
        viewModel.fetchUsers()
        wait(for: [expectation], timeout: 5.0)
    }
}
