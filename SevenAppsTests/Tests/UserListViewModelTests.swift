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
    var mockRepository: MockUserRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockUserRepository()
        viewModel = UserListViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    /// Kullanıcı listesinin başarıyla alındığını test eder.
    func testFetchUsersSuccess() {
        let expectation = XCTestExpectation(description: "ViewModel kullanıcıları başarılı bir şekilde çekti")

        viewModel.onUsersUpdated = {
            XCTAssertFalse(self.viewModel.users.isEmpty, "ViewModel kullanıcı listesi boş olmamalı")
            XCTAssertEqual(self.viewModel.users.count, self.mockRepository.mockUsers.count, "ViewModel'deki kullanıcı sayısı mock verisiyle aynı olmalı")
            expectation.fulfill()
        }
        
        viewModel.fetchUsers()
        wait(for: [expectation], timeout: 5.0)
    }

    /// Hata durumunda doğru hata mesajının döndüğünü test eder.
    func testFetchUsersFailure() {
        let expectation = XCTestExpectation(description: "ViewModel hata mesajını doğru şekilde döndürmeli")

        mockRepository.shouldReturnError = true  // Mock servisin hata döndürmesini sağlıyoruz.
        
        viewModel.onError = { errorMessage in
            XCTAssertEqual(errorMessage, ErrorManager.handle(error: NetworkError.requestFailed(NSError(domain: "", code: -1009, userInfo: nil))), "Hata mesajı beklenen mesaj olmalı")
            expectation.fulfill()
        }
        
        viewModel.fetchUsers()
        wait(for: [expectation], timeout: 5.0)
    }
}
