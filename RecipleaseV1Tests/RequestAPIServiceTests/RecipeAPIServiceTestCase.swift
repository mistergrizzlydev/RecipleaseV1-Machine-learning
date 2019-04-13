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
	
	func testRequestRecipesDetailShouldPostFailedCallbackIfError () {
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testRequestRecipesShouldPostFailedcallbackIfErrorNoData () {// NoData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testRequestRecipesShouldPostFailedcallbackIfErrorIfIncorrectResponse() { // IfIncorrectResponse
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestRecipesShouldPostFailedcallbackIfErrorIfIncorrectData() { // ErrorIfIncorrectData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	// - Test Succes callback
	func testRequestRecipesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {// No Error and CorrectData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			XCTAssertTrue(success)
			XCTAssertNotNil(data)
			XCTAssertEqual(data?.name, "The BEST Crockpot Pot Roast")
			//XCTAssertEqual(currency?.rates["USD"], 1.131305)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}

	func testRequestRecipesShouldPostFailedCallbackIfError () { // CallbackIfError
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestRecipesShouldPostFailedCallbackIfErrorNoData () {// NoData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestRecipesShouldPostFailedCallbackIfErrorIfIncorrectResponse() { // IfIncorrectResponse
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestRecipesShouldPostFailedCallbackIfErrorIfIncorrectData() { // ErrorIfIncorrectData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestRecipesShouldPostSuccessCallbackIfNoErrorAndNoData() {// Data correct and no error
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			XCTAssertNil(data)
			XCTAssertEqual(data?.id , nil)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}

	//========================================================================================
	// MARK : - test request Recipe
	//========================================================================================
	
	func testGetRecipeDetailShouldPostFailedCallbackIfError () { // CallbackIfError
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestListRecipes(recipeList: []){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetRecipeDetailShouldPostFailedcallbackIfErrorNoData () {// NoData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestListRecipes(recipeList: []){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetRecipeDetailShouldPostFailedcallbackIfErrorIfIncorrectResponse() { // IfIncorrectResponse
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestListRecipes(recipeList: []){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testGetRecipeDetailShouldPostFailedcallbackIfErrorIfIncorrectData() { // ErrorIfIncorrectData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestListRecipes(recipeList: []){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	// - Test Succes callback
	func testGetRecipeDetailShouldPostSuccessCallbackIfNoErrorAndCorrectData() {// NoData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let urlSessionFake = UrlSessionFake(fakeResponse: fakeResponse)
		let urlService = UrlService(urlSession: urlSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		urlService.requestListRecipes(recipeList: []){ (success, data) in // changement de Queue
			XCTAssertTrue(success)
			XCTAssertNotNil(data)
			//XCTAssertEqual(currency?.rates["USD"], 1.131305)
			//XCTAssertEqual(data?.name , "The BEST Crockpot Pot Roast")
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}

}

