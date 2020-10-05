//
//  Log.swift
//  Pequod
//
//  Created by Joe Charlier on 7/11/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

public class Log {
	static var fileURL: URL?
	
	public static func initialize(path: String) {
		let fileURL = URL(fileURLWithPath: path)
		if !FileManager.default.fileExists(atPath: fileURL.path) {
			FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
		}
	}

	public static func print(_ string: String) {
		Swift.print(string)
		guard let fileURL = fileURL else { return }
		guard let data: Data = "[\(Date().toISOFormattedString())] \(string)\n".data(using: .utf8) else { return }
		guard let fileHandle = FileHandle(forWritingAtPath: fileURL.path) else { return }
		defer { fileHandle.closeFile() }
		fileHandle.seekToEndOfFile()
		fileHandle.write(data)
	}
}
