//
//  Ping.swift
//  Cocytus
//
//  Created by Joe Charlier on 4/12/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation
import PerfectHTTP

public class Ping: Radical {
	init() {
		super.init(method: .get, path: "/ping")
	}
	
// Radical =========================================================================================
	public override func execute (request: HTTPRequest, response: HTTPResponse) -> [String:Any] {
//		var sb: String = "[ping]"
//		defer {Log.print(sb)}
		return [:]
	}
}
