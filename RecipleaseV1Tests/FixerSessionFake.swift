//
//  FixerSessionFake.swift
//  RecipleaseV1Tests
//
//  Created by VINCENT BOULANGER on 26/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import Alamofire
@testable import RecipleaseV1

class FixerSessionFake: FixerSession {
	private let fakeResponse: FakeResponse
	init(fakeResponse: FakeResponse) {
		self.fakeResponse = fakeResponse
		super.init()
	}
	override func request (url: URL, completionHandler: @escaping(DataResponse<Any>) -> Void) {
		let httpResponse = fakeResponse.response
		let data = fakeResponse.data
		let error = fakeResponse.error
		let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: error)
		let urlRequest = URLRequest(url: URL(string: urlStringApi)!)
		completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
	}
}
