//
//  LoginTests.swift
//  ProAppTests
//
//  Created by Vineet Mishra on 10/12/24.
//

import XCTest
@testable import ProApp
final class LoginTests: XCTestCase {

    var viewModel: LoginViewModel! = nil
    var mockAuth :MockAuthenticationService! = nil
    override func setUpWithError() throws {
        mockAuth = MockAuthenticationService()
        viewModel = LoginViewModel(authService: mockAuth)
    }

    override func tearDownWithError() throws {
        mockAuth = nil
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginViewModel_ValidateEmail_returnNil(){
        viewModel.email = "vineet@gmail.com"
        XCTAssertNil(viewModel.validateEmail())
    }

    func testLoginViewModel_ValidateEmail_returnError(){
        viewModel.email = ""
        XCTAssertEqual("Email is required.", viewModel.validateEmail())
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


//
//class LoginViewModelTests: XCTestCase {
//    
//    var viewModel: LoginViewModel!
//    var mockAuthService: MockAuthenticationService!
//
//    override func setUp() {
//        super.setUp()
//        mockAuthService = MockAuthenticationService()
//        viewModel = LoginViewModel(authService: mockAuthService)
//    }
//
//    override func tearDown() {
//        viewModel = nil
//        mockAuthService = nil
//        super.tearDown()
//    }
//
//    // MARK: - Email Validation Tests
//
//    func testValidateEmail_emptyEmail_returnsError() {
//        viewModel.email = ""
//        XCTAssertEqual(viewModel.validateEmail(), "Email is required.")
//    }
//
//    func testValidateEmail_invalidEmail_returnsError() {
//        viewModel.email = "invalid-email"
//        XCTAssertEqual(viewModel.validateEmail(), "Invalid email format.")
//    }
//
//    func testValidateEmail_validEmail_returnsNil() {
//        viewModel.email = "user@example.com"
//        XCTAssertNil(viewModel.validateEmail())
//    }
//
//    // MARK: - Password Validation Tests
//
//    func testValidatePassword_emptyPassword_returnsError() {
//        viewModel.password = ""
//        XCTAssertEqual(viewModel.validatePassword(), "Password is required.")
//    }
//
//    func testValidatePassword_shortPassword_returnsError() {
//        viewModel.password = "123"
//        XCTAssertEqual(viewModel.validatePassword(), "Password must be at least 6 characters long.")
//    }
//
//    func testValidatePassword_validPassword_returnsNil() {
//        viewModel.password = "password123"
//        XCTAssertNil(viewModel.validatePassword())
//    }
//
//    // MARK: - Login Behavior Tests
//
//    func testLogin_withValidCredentials_callsLoginAndSucceeds() {
//        // Arrange
//        mockAuthService.shouldSucceed = true
//        viewModel.email = "user@example.com"
//        viewModel.password = "password123"
//        
//        let expectation = XCTestExpectation(description: "Login succeeds")
//        
//        // Act
//        viewModel.login()
//        
//        // Assert
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            XCTAssertTrue(self.viewModel.isLoginSuccessful)
//            XCTAssertNil(self.viewModel.loginError)
//            expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 2)
//    }
//
//    func testLogin_withInvalidCredentials_callsLoginAndFails() {
//        // Arrange
//        mockAuthService.shouldSucceed = false
//        viewModel.email = "user@example.com"
//        viewModel.password = "password123"
//        
//        let expectation = XCTestExpectation(description: "Login fails")
//        
//        // Act
//        viewModel.login()
//        
//        // Assert
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            XCTAssertFalse(self.viewModel.isLoginSuccessful)
//            XCTAssertEqual(self.viewModel.loginError, "Login failed")
//            expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 2)
//    }
//
//    func testLogin_withInvalidForm_doesNotCallLogin() {
//        // Arrange
//        viewModel.email = "invalid-email"
//        viewModel.password = "short"
//        
//        // Act
//        viewModel.login()
//        
//        // Assert
//        XCTAssertEqual(viewModel.loginError, "Invalid email or password.")
//        XCTAssertFalse(viewModel.isLoginSuccessful)
//    }
//}
//
