//
//  FixerSession.swift
//  RecipleaseV1Tests
//
//  Created by VINCENT BOULANGER on 26/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
// remplace URL Session

import Foundation
import Alamofire

class FixerSession: FixerProtocol {
	func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
		Alamofire.request(url).responseJSON { responseData in completionHandler(responseData)
		}
	}
}
