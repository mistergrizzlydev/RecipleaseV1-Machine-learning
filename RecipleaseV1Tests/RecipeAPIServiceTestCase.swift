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
	
	//========================================
	// MARK : - test Recipe Detail
	//========================================
	// - Test URLRequest
	
	func testRequestRecipeDetailShouldPostFailedCallbackIfError () {
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testRequestRecipeShouldPostFailedcallbackIfErrorNoData () {// NoData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testRequestRecipeShouldPostFailedcallbackIfErrorIfIncorrectResponse() { // IfIncorrectResponse
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestRecipeShouldPostFailedcallbackIfErrorIfIncorrectData() { // ErrorIfIncorrectData
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	// - Test Succes callback
	func testRequestRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {// NoData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			XCTAssertTrue(success)
			XCTAssertNotNil(data)
			//XCTAssertEqual(currency?.rates["USD"], 1.131305)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	//=================================================================================================
	// test testRequestListRecipes
	//=================================================================================================
	func testRequestRecipeShouldPostFailedCallbackIfError () { // CallbackIfError
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestRecipeShouldPostFailedCallbackIfErrorNoData () {// NoData
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestRecipeShouldPostFailedCallbackIfErrorIfIncorrectResponse() { // IfIncorrectResponse
//		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestRecipeShouldPostFailedCallbackIfErrorIfIncorrectData() { // ErrorIfIncorrectData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData22222() {// Data correct and no error
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: "The-BEST-Crockpot-Pot-Roast-2631670"){ (success, data) in // changement de Queue
			XCTAssertTrue(success)
			XCTAssertNotNil(data)
			//XCTAssertEqual(data?.id[0] , "The-BEST-Crockpot-Pot-Roast-2631670")
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	//========================================================================================
	//========================================================================================
	// MARK : - test Recipe List
	//========================================================================================
	//========================================================================================
	
	
	// - Test URLRequest
	
	func testRequestListRecipesShouldPostFailedCallbackIfError () {
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testRequestListRecipesShouldPostFailedcallbackIfErrorNoData () {// NoData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testRequestListRecipesShouldPostFailedcallbackIfErrorIfIncorrectResponse() { // IfIncorrectResponse
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestListRecipesShouldPostFailedcallbackIfErrorIfIncorrectData() { // ErrorIfIncorrectData
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	// - Test Succes callback
	func testRequestListRecipesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {// NoData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			XCTAssertTrue(success)
			XCTAssertNotNil(data)
			//XCTAssertEqual(currency?.rates["USD"], 1.131305)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	//=================================================================================================
	// test GetListCurrencies
	//=================================================================================================
	func testRequestListRecipesCurrenciesShouldPostFailedCallbackIfError () { // CallbackIfError
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestListRecipesCurrenciesShouldPostFailedcallbackIfErrorNoData () {// NoData
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestListRecipesCurrenciesShouldPostFailedcallbackIfErrorIfIncorrectResponse() { // IfIncorrectResponse
		//		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestListRecipesCurrenciesShouldPostFailedcallbackIfErrorIfIncorrectData() { // ErrorIfIncorrectData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestListRecipesCurrenciesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {// Data correct and no error
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let fixerSessionFake = FixerSessionFake(fakeResponse: fakeResponse)
		let fixerService = FixerService(fixerSession: fixerSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		fixerService.requestRecipeDetail(recipeID: "The-BEST-Crockpot-Pot-Roast-2631670"){ (success, data) in // changement de Queue
			XCTAssertTrue(success)
			XCTAssertNotNil(data)
			//XCTAssertEqual(data?.id[0] , "The-BEST-Crockpot-Pot-Roast-2631670")
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
}

