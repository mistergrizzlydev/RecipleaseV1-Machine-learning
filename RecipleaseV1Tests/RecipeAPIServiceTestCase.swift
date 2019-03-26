//
//  RecipleaseV1Tests.swift
//  RecipleaseV1Tests
//
//  Created by VINCENT BOULANGER on 26/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//
import Foundation
import XCTest
@testable import RecipleaseV1

class RecipeAPIServiceTestCase: XCTestCase {
	var recipeAPIService: RecipeAPIService!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()
		recipeAPIService = RecipeAPIService()
    }
	// - Test URLRequest
	
	func testGetCurrencyShouldPostFailedCallbackIfError () {
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
//		let recipeAPIService  = RecipeAPIService(
//			currencySession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, currency) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(currency)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetCurrencyShouldPostFailedcallbackIfErrorNoData () {// NoData
		// given
		let currencyAPIService  = CurrencyAPIService(
			currencySession: URLSessionFake(data: nil, response: nil, error: nil))
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		currencyAPIService.getCurrency(targetDevise: ""){ (success, currency) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(currency)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetCurrencyShouldPostFailedcallbackIfErrorIfIncorrectResponse() { // IfIncorrectResponse
		// given
		let currencyAPIService  = CurrencyAPIService(
			currencySession: URLSessionFake(data: FakeResponseData.networkCorrectData, response: FakeResponseData.responseKO, error: nil))
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		currencyAPIService.getCurrency(targetDevise: ""){ (success, currency) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(currency)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testGetCurrencyShouldPostFailedcallbackIfErrorIfIncorrectData() { // ErrorIfIncorrectData
		// given
		let currencyAPIService  = CurrencyAPIService(
			currencySession: URLSessionFake(data: FakeResponseData.networkIncorrectData , response: FakeResponseData.responseOK, error: nil))
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		currencyAPIService.getCurrency(targetDevise: ""){ (success, currency) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(currency)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	// - Test Succes callback
	func testGetCurrencyShouldPostSuccessCallbackIfNoErrorAndCorrectData() {// NoData
		// given
		let currencyAPIService  = CurrencyAPIService(
			currencySession: URLSessionFake(data: FakeResponseData.networkCorrectData, response: FakeResponseData.responseOK, error: nil))
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		currencyAPIService.getCurrency(targetDevise: ""){ (success, currency) in // changement de Queue
			XCTAssertTrue(success)
			XCTAssertNotNil(currency)
			XCTAssertEqual(currency?.rates["USD"], 1.131305)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	//=================================================================================================
	// test GetListCurrencies
	//=================================================================================================
	func testGetListCurrenciesShouldPostFailedCallbackIfError () { // CallbackIfError
		let currencyAPIService  = CurrencyAPIService(
			currencySession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		currencyAPIService.getListCurrencies(){ (success, currency) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(currency)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testGetListCurrenciesShouldPostFailedcallbackIfErrorNoData () {// NoData
		// given
		let currencyAPIService  = CurrencyAPIService(
			currencySession: URLSessionFake(data: nil, response: nil, error: nil))
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		currencyAPIService.getListCurrencies(){ (success, currency) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(currency)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testGetListCurrenciesShouldPostFailedcallbackIfErrorIfIncorrectResponse() { // IfIncorrectResponse
		// given
		let currencyAPIService  = CurrencyAPIService(
			currencySession: URLSessionFake(data: FakeResponseData.networkCorrectData, response: FakeResponseData.responseKO, error: nil))
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		currencyAPIService.getListCurrencies(){ (success, currency) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(currency)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testGetListCurrenciesShouldPostFailedcallbackIfErrorIfIncorrectData() { // ErrorIfIncorrectData
		// given
		let currencyAPIService  = CurrencyAPIService(
			currencySession: URLSessionFake(data: FakeResponseData.networkIncorrectData , response: FakeResponseData.responseOK, error: nil))
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		currencyAPIService.getListCurrencies(){ (success, currency) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(currency)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testGetListCurrenciesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {// Data correct and no error
		// given
		let currencyAPIService  = CurrencyAPIService(
			currencySession: URLSessionFake(data: FakeResponseData.listCurrenciesCorrectData, response: FakeResponseData.responseOK, error: nil))
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		currencyAPIService.getListCurrencies(){ (success, currency) in // changement de Queue
			XCTAssertTrue(success)
			XCTAssertNotNil(currency)
			XCTAssertEqual(currency?.symbols["AED"], "United Arab Emirates Dirham")
			
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}

}
