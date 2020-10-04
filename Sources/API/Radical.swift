//
//  Radical.swift
//  Cocytus
//
//  Created by Joe Charlier on 4/12/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation
import PerfectHTTP

class Radical {
	var method: HTTPMethod
	var path: String

	init (method: HTTPMethod, path: String) {
		self.method = method
		self.path = path
	}
	
	static func sanitize(uuid: Any?) -> String? {
		return UUID(uuidString: uuid as? String ?? "")?.uuidString
	}

	func execute (request: HTTPRequest, response: HTTPResponse) -> [String:Any] {
		return [:]
	}
	
	final func handler (request: HTTPRequest, response: HTTPResponse) {
		response.setHeader(.contentType, value: "text/json")
		response.appendBody(string: execute(request: request, response: response).toJSON())
		response.completed()
	}
}
