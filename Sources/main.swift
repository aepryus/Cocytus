//
//  File.swift
//  
//
//  Created by Joe Charlier on 1/24/20.
//

import Foundation

print("Hello, Cocytus")

class Test: Domain {
	var apple: String = ""
}

let test = Test()

test["apple"] = "red"

print(">> \(test.apple)")
