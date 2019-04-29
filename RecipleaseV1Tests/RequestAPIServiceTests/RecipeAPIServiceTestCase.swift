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
	var recipeSession = RecipesSession()
	var recipeAPIService: RecipeAPIService!
	
	//========================================
	// MARK : - test Recipe Detail
	//========================================
	// - Test URLRequest
	//1
	func testRequestRecipesDetailShouldPostFailedCallbackIfError () {

		let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
		let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
		let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		recipeAPIService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	//2
	func testRequestRecipesDetailShouldPostFailedcallbackIfNoData () {// NoData
		// given
		let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)// CallbackIfError
		let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
		let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		recipeAPIService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
////------------------------------------
	//3
	func testRequestRecipesDetailShouldPostFailedcallbackIfIncorrectResponse() { // IfIncorrectResponse
//		// given
		let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctDataRecipeDetail , error: nil)// CallbackIfError
		let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
		let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		recipeAPIService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
//			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	//4
	func testRequestRecipesDetailShouldPostFailedCallbackIfResponseCorrectAndNilData() { // ErrorIfIncorrectData
		// given
		let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
		let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
		let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		recipeAPIService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}

	// - Test Succes callback
	//5
	func testRequestRecipesDetailShouldPostSuccessCallbackIfNoErrorAndIncorrectData() { // CallbackIfError
		// given
		let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData , error: nil)
		let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
		let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		recipeAPIService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	//6
	func testRequestRecipesDetailShouldPostCallbackIfCorrectData() {// No Error and IncorrectData
		// given
		let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctDataRecipeDetail , error: nil)
		let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
		let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		recipeAPIService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			XCTAssertTrue(success)
			XCTAssertNotNil(data)
			XCTAssertEqual(data?.name, "The BEST Crockpot Pot Roast")
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	func testRequestRecipesDetailShouldPostFailedcallbackIfErrorNoData () {// NoData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil , error: nil)
		let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
		let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		recipeAPIService.requestRecipeDetail(recipeID: ""){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
	}
////	//========================================================================================
////	// MARK : - test request Recipe List
////	//========================================================================================
	func testRequestRecipesShouldPostFailedCallbackIfError2 () {
		let fakeResponse = FakeResponse(response: FakeResponseData.responseOK , data: FakeResponseData.incorrectData, error: nil)// CallbackIfError
		let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
		let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		recipeAPIService.requestListRecipes(recipeList: [""]  ){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
////	//1
		func testRequestRecipesShouldPostFailedCallbackIfError () {
			let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)// CallbackIfError
			let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
			let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
			// When
			let expectation = XCTestExpectation(description: "Wait for queue change ")
			recipeAPIService.requestListRecipes(recipeList: [""]  ){ (success, data) in // changement de Queue
				//Then
				XCTAssertFalse(success)
				XCTAssertNil(data)
				expectation.fulfill()
			}
			wait(for: [expectation], timeout: 0.01)
		}
	//2
		func testRequestRecipesShouldPostFailedcallbackIfNoData () {// NoData
			// given
			let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)// CallbackIfError
			let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
			let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
			// When
			let expectation = XCTestExpectation(description: "Wait for queue change ")
			recipeAPIService.requestListRecipes(recipeList: [""]  ){ (success, data) in // changement de Queue
				//Then
				XCTAssertFalse(success)
				XCTAssertNil(data)
				expectation.fulfill()
			}
			wait(for: [expectation], timeout: 0.01)
		}
	//////------------------------------------
	//3
		func testRequestRecipesShouldPostFailedcallbackIfIncorrectResponse() { // IfIncorrectResponse
	//		// given
			let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctDataRecipeList , error: nil)// CallbackIfError
			let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
			let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
			// When
			let expectation = XCTestExpectation(description: "Wait for queue change ")
			recipeAPIService.requestListRecipes(recipeList: [""]  ){ (success, data) in // changement de Queue
	//			//Then
				XCTAssertFalse(success)
				XCTAssertNil(data)
				expectation.fulfill()
			}
			wait(for: [expectation], timeout: 0.01)
		}
	//4
		func testRequestRecipesShouldPostFailedCallbackIfResponseCorrectAndNilData() { // ErrorIfIncorrectData
			// given
			let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
			let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
			let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
			// When
			let expectation = XCTestExpectation(description: "Wait for queue change ")
			recipeAPIService.requestListRecipes(recipeList: [""]  ){ (success, data) in // changement de Queue
				XCTAssertFalse(success)
				XCTAssertNil(data)
				expectation.fulfill()
			}
			wait(for: [expectation], timeout: 0.01)
		}
	//5
	//5
	func testGetExchangeRateShouldPostFailedCallbackIfIncorrectData() {
		let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
		let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
		let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		recipeAPIService.requestListRecipes(recipeList: [""]  ){ (success, data) in // changement de Queu
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 0.01)
	}
	//	// - Test Succes callback
		func testRequestRecipesShouldPostCallbackIfCorrectData() {// No Error and CorrectData
			// given
			let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctDataRecipeList , error: nil)
			let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
			let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
			// When
			let expectation = XCTestExpectation(description: "Wait for queue change ")
			recipeAPIService.requestListRecipes(recipeList: [""]  ){ (success, data) in // changement de Queue
				XCTAssertTrue(success)
				XCTAssertNotNil(data)
				XCTAssertEqual(data?.matches[0].id , "The-BEST-Crockpot-Pot-Roast-2631670")
				expectation.fulfill()
			}
			wait(for: [expectation], timeout: 0.01)
		}
	func testRequestRecipesShouldPostFailedcallbackIfErrorNoData () {// NoData
		// given
		let fakeResponse = FakeResponse(response: nil, data: nil , error: nil)
		let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
		let recipeAPIService = RecipeAPIService(recipeSession: recipesSessionFake)
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change ")
		recipeAPIService.requestListRecipes(recipeList: [""]  ){ (success, data) in // changement de Queue
			//Then
			XCTAssertFalse(success)
			XCTAssertNil(data)
			expectation.fulfill()
		}
	}
	func testmAcouille () {
		
	}
	//
//-----------------------------------------------------
// Test Construct URL
//-----------------------------------------------------
	
	func testUrlConstructRecipeList() {
		let ingredient = "&allowedIngredient[]=lemon"
		XCTAssertEqual("\(recipeSession.urlStringApi)_app_id=\(recipeSession.appId)&_app_key=\(recipeSession.appKey)\(ingredient)", "https://api.yummly.com/v1/api/recipes?_app_id=654bf699&_app_key=7c4b6ee18b43f40b31fbd410264f2376&allowedIngredient[]=lemon")
	}
	func testUrlConstructRecipeDetail() {
		let recipeID = "Garlic-Ginger-Sesame-Soy-Noodle-Sauce-2654634"
		XCTAssertEqual("\(recipeSession.urlStringApiDetail)\(recipeID)?_app_id=\(recipeSession.appId)&_app_key=\(recipeSession.appKey)", "https://api.yummly.com/v1/api/recipe/Garlic-Ginger-Sesame-Soy-Noodle-Sauce-2654634?_app_id=654bf699&_app_key=7c4b6ee18b43f40b31fbd410264f2376")
	}
}
