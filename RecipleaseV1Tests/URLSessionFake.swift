//
//  URLSessionFake.swift
//  Baluchon-V1.0Tests
//
//  Created by VINCENT BOULANGER on 12/11/2018.
//  Copyright © 2018 VBoulanger. All rights reserved.
//

import Foundation

class URLSessionFake: URLSession {
	var data:Data?
	var response: URLResponse?
	var error: Error?
	
	init(data: Data?, response: URLResponse?, error: Error?) {
		self.data = data
		self.response = response
		self.error = error
	}
	
	override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		let task = URLSessionDataTaskFake()
		task.callback = completionHandler
		task.data = data
		task.urlResponse = response
		task.responseError = error
		return task
	}
}
class URLSessionDataTaskFake: URLSessionDataTask { // simule URLSessionDataTask mais ne lance pas l'appel
	var callback: ((Data?, URLResponse?, Error?) -> Void)?
	var data:Data?
	var urlResponse: URLResponse?
	var responseError: Error?
	
	override func resume() {
		callback?(data, urlResponse, responseError)
	}
	override func cancel() {}
}
