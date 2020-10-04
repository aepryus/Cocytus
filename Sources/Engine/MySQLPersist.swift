//
//  MySQLPersist.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Dispatch
import Foundation
import PerfectMySQL
import PerfectThread

class MySQLPool {
	var name: String
	private var r: Int = 0
	private var n: Int = 20
	private var readDBs = [MySQL]()
	private var writeDBs = [MySQL]()
	private let queue = DispatchQueue(label: "pool")
	
	private init(name: String) {
		self.name = name

		refreshConnections()
		
		Threading.dispatch {
			while true {
				sleep(3600*4)
				print("refreshing MySQL connections...")
				self.refreshConnections()
			}
		}
	}
	
	private func createDB() -> MySQL {
		let db = MySQL()
		if db.connect(host:"127.0.0.1", user:name, password:name) == false {
			print("Connection to \(name.capitalize) MySQL database failed")
		} else if db.selectDatabase(named: name) == false {
			print("use failed")
		}
		return db
	}
	
	func grabReadDB() -> MySQL {
		var db: MySQL? = nil
		queue.sync {
			db = readDBs[r]
			r += 1
			if (r == n) {r = 0}
		}
		return db!
	}
	func borrowWriteDB() -> MySQL {
		var db: MySQL? = nil
		queue.sync {
			if writeDBs.count == 0 {
				db = createDB()
			} else {
				db = writeDBs.removeLast()
			}
		}
		return db!
	}
	func returnWriteDB(_ db: MySQL) {
		queue.sync {
			writeDBs.append(db)
		}
	}
	
	func refreshConnections() {
		queue.sync {
			writeDBs.removeAll()
			readDBs.removeAll()
			for _ in 0..<n {
				readDBs.append(createDB())
			}
		}
	}
	
	static var pools: [String:MySQLPool] = [:]
	static func pool(name: String) -> MySQLPool {
		if let pool = pools[name] {
			return pool
		} else {
			let pool = MySQLPool(name: name)
			pools[name] = pool
			return pool
		}
	}
}

class MySQLPersist: Persist {
	let pool: MySQLPool
	
	override init(name: String) {
		pool = MySQLPool.pool(name: name)
		super.init(name: name)
	}
	override init(name: String, acnt: UUID) {
		pool = MySQLPool.pool(name: name)
		super.init(name: name, acnt: acnt)
	}
	
	static let dateFormatter: DateFormatter = {
		let dateFormatter: DateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return dateFormatter
	}()
	
// Private =========================================================================================
	private func query(_ query: String) -> [[String:Any]] {
		let db = pool.grabReadDB()
		let s = MySQLStmt(db)
		guard s.prepare(statement: query)
			else {print("query(_ query: String) prepare creation failed [\(db.errorMessage())]"); return []}
		
		guard s.execute()
			else {print("prepare execution failed [\(db.errorMessage())]"); return []}
		
		var result = [[String:Any]]()
		
		guard s.results().forEachRow(callback: {(row: MySQLStmt.Results.Element) in
			var attributes = [String:Any]()
			for i: Int in 0..<Int(s.fieldCount()) {
				guard let info = s.fieldInfo(index: i) else {continue}
				
				if info.type == .bytes {
					attributes[info.name] = String(bytes: row[i] as! [UInt8], encoding: .utf8)
				} else if info.type == .date {
					attributes[info.name] = MySQLPersist.dateFormatter.date(from: row[i] as! String)
				} else {
					attributes[info.name] = row[i]
				}
			}
			result.append(attributes)
		})
			else {print("results failed [\(db.errorMessage())]"); return []}
		
		return result
	}
	
// Persist =========================================================================================
	override func echo(_ from: Int) -> [UUID] {
		guard let acnt = acnt else {return []}
		var result = [UUID]()
		let rows = query("SELECT iden FROM vellum WHERE acnt='\(acnt)' AND fork>\(from)")
		for row in rows {
			result.append(UUID(uuidString: row["iden"] as! String)!)
		}
		return result;
	}
	override func listAllIdens() -> [String] {
		guard let acnt = acnt else {return []}

		let rows = query("SELECT iden FROM vellum WHERE acnt='\(acnt)'")
		
		var idens = [String]()
		
		for attributes in rows {
			idens.append(attributes["iden"] as! String)
		}
		
		return idens
	}
	override func transact(_ transact: ()->(Bool)) {
		let result = transact()
		if result {
		} else {
			print("transaction failed")
		}
	}

// Account =========================================================================================
	override func store(account: Account) {
		let db = pool.borrowWriteDB()
		defer {pool.returnWriteDB(db)}
		
		let s = MySQLStmt(db)
		guard s.prepare(statement: "REPLACE INTO account (acnt, otid, expires, user, email, name, fork, token, since) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)")
			else {print("store (account: Account) prepare creation failed [\(db.errorMessage())]"); return}
		
		s.bindParam(account.acnt.uuidString)
		s.bindParam(account.otid)
		s.bindParam(account.expires.format("yyyy-MM-dd HH:mm:ss"))
		if let user = account.user {s.bindParam(user)} else {s.bindParam()}
		if let email = account.email {s.bindParam(email)} else {s.bindParam()}
		if let name = account.name {s.bindParam(name)} else {s.bindParam()}
		s.bindParam(account.fork)
		s.bindParam(account.token)
		s.bindParam(account.since)
		
		guard s.execute()
			else {print("prepare execution failed [\(db.errorMessage())]"); return}
	}
	private func toAccount(attributes: [String:Any]) -> Account {
		let acnt: UUID = UUID(uuidString: attributes["acnt"] as! String)!
		let otid: String = attributes["otid"] as! String
		
		let expires: Date = attributes["expires"] as! Date
		let user: String? = attributes["user"] as? String
		let email: String? = attributes["email"] as? String
		let name: String? = attributes["name"] as? String
		let fork: Int = Int(attributes["fork"] as! String)!
		let token: String = attributes["token"] as! String
		let since: Int = Int(attributes["since"] as! String? ?? "0")!
		
		return Account(acnt: acnt, otid: otid, expires: expires, user: user, email: email, name: name, fork: fork, token: token, since: since)
	}
	override func account(acnt: UUID) -> Account? {
		let rows = query("SELECT * From account WHERE acnt = '\(acnt.uuidString)'")
		guard rows.count == 1 else {return nil}
		let attributes = rows[0]
		return toAccount(attributes: attributes)
	}
	override func account(otid: String) -> Account? {
		let rows = query("SELECT * From account WHERE otid = '\(otid)'")
		guard rows.count == 1 else {return nil}
		let attributes = rows[0]
		return toAccount(attributes: attributes)
	}
	override func account(user: String) -> Account? {
		let rows = query("SELECT * From account WHERE user = '\(user)'")
		guard rows.count == 1 else {return nil}
		let attributes = rows[0]
		return toAccount(attributes: attributes)
	}
	override func account(token: String) -> Account? {
		let rows = query("SELECT account.* From account, device WHERE account.acnt = device.acnt AND device.token = '\(token)'")
		guard rows.count == 1 else {return nil}
		let attributes = rows[0]
		return toAccount(attributes: attributes)
	}
	
// Memory ==========================================================================================
	override func store(memory: Memory) {
		let db = pool.borrowWriteDB()
		defer {pool.returnWriteDB(db)}

		let s = MySQLStmt(db)
		guard s.prepare(statement: "REPLACE INTO memory (acnt, name, value, vers, fork, born, gone) VALUES (?, ?, ?, ?, ?, ?, ?)")
			else {print("store(memory: Memory) prepare creation failed [\(db.errorMessage())]"); return}
		
		s.bindParam(memory.acnt.uuidString)
		s.bindParam(memory.name)
		s.bindParam(memory.value)
		s.bindParam(memory.vers)
		s.bindParam(memory.fork)
		s.bindParam(memory.born)

		if let gone = memory.gone {
			s.bindParam(gone)
		} else {
			s.bindParam()
		}
		
		guard s.execute()
			else {print("store(memory: Memory) prepare execution failed [\(db.errorMessage())]"); return}
	}
	private func toMemory(attributes: [String:Any]) -> Memory {
		let acnt: UUID = UUID(uuidString: attributes["acnt"] as! String)!
		let name: String = attributes["name"] as! String
		let value: String = attributes["value"] as! String
		let vers: Int = Int(attributes["vers"] as! String)!
		let fork: Int = Int(attributes["fork"] as! String)!
		let born: Int = fork
		let gone: Int? = Int(attributes["gone"] as! String)

		return Memory(acnt: acnt, name: name, value: value, vers: vers, fork: fork, born: born, gone: gone)
	}
	override func memory(name: String) -> Memory? {
		guard let acnt = acnt else {return nil}
		let rows = query("SELECT * FROM memory WHERE acnt = '\(acnt.uuidString)' AND name = '\(name)'")
		guard rows.count == 1 else {return nil}
		let attributes = rows[0]
		return toMemory(attributes: attributes)
	}
	
// Device ===========================================================================================
	override func store(device: Device) {
		let db = pool.borrowWriteDB()
		defer {pool.returnWriteDB(db)}

		let s = MySQLStmt(db)
		guard s.prepare(statement: "REPLACE INTO device (token, acnt, tag, fork, synced) VALUES (?, ?, ?, ?, ?)")
			else {print("store(device: Device) prepare creation failed [\(db.errorMessage())]"); return}
		
		s.bindParam(device.token)
		s.bindParam(device.acnt.uuidString)
		s.bindParam(device.tag)
		s.bindParam(device.fork)
		
		if let synced = device.synced {
			s.bindParam(synced)
		} else {
			s.bindParam()
		}
		
		guard s.execute()
			else {print("store(device: Device) prepare execution failed [\(db.errorMessage())]"); return}
	}
	private func toDevice(attributes: [String:Any]) -> Device {
		let token: String = attributes["token"] as! String
		let acnt: UUID = UUID(uuidString: attributes["acnt"] as! String)!
		let tag: String = attributes["tag"] as! String
		let fork: Int = Int(attributes["fork"] as! String)!
		let synced: String? = attributes["synced"] as? String
		
		return Device(token: token, acnt: acnt, tag: tag, fork: fork, synced: synced)
	}
	override func device(token: String) -> Device? {
		let rows = query("SELECT * FROM device WHERE token = '\(token)'")
		guard rows.count == 1 else {return nil}
		let attributes = rows[0]
		return toDevice(attributes: attributes)
	}
	override func delete(device: Device) {
		let db = pool.borrowWriteDB()
		defer {pool.returnWriteDB(db)}
		
		let s = MySQLStmt(db)
		guard s.prepare(statement: "DELETE FROM device WHERE token = '\(device.token)'")
			else {print("delete(device: Device) prepare creation failed [\(db.errorMessage())]"); return}
		
		guard s.execute()
			else {print("delete(device: Device) prepare execution failed [\(db.errorMessage())]"); return}
	}
	
// Vellum ==========================================================================================
	override func store(vellum: Vellum) {
		let db = pool.borrowWriteDB()
		defer {pool.returnWriteDB(db)}

		let s = MySQLStmt(db)
		guard s.prepare(statement: "REPLACE INTO vellum (acnt, iden, type, only, json, vers, fork, born, gone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)")
			else {print("store(vellum: Vellum) prepare creation failed [\(db.errorMessage())]"); return}
		
		s.bindParam(vellum.acnt.uuidString)
		s.bindParam(vellum.iden.uuidString)
		s.bindParam(vellum.type)
		
		if let only = vellum.only {
			s.bindParam(only)
		} else {
			s.bindParam()
		}
		
		do {
			let data = try JSONSerialization.data(withJSONObject: vellum.attributes, options: [])
			let JSON: String = String(data: data, encoding: .utf8)!
			s.bindParam(JSON)
		} catch {
			s.bindParam()
			print("error generating JSON [\(error)]")
			return
		}
		
		s.bindParam(vellum.vers)
		s.bindParam(vellum.fork)
		s.bindParam(vellum.born)
		
		if let gone = vellum.gone {
			s.bindParam(gone)
		} else {
			s.bindParam()
		}
		
		
		guard s.execute()
			else {print("prepare execution failed [\(db.errorMessage())]"); return}
	}
	private func toVellum(attributes: [String:Any]) -> Vellum {
		let acnt: UUID = UUID(uuidString: attributes["acnt"] as! String)!
		let iden: UUID = UUID(uuidString: attributes["iden"] as! String)!
		let type: String = attributes["type"] as! String
		let only: String? = attributes["only"] as! String?
		let json: String = attributes["json"] as! String
		let vers: Int = Int(attributes["vers"] as! String)!
		let fork: Int = Int(attributes["fork"] as! String)!
		let born = fork

		var gone: Int? = nil
		if let text = attributes["Gone"] as? String {
			gone = Int(text)
		}
		
		let vellum = Vellum(acnt: acnt, iden: iden, type: type, only: only, json: json, vers: vers, fork: fork, born: born, gone: gone)
		
		vellum.attributes = json.toAttributes()
		
		return vellum
	}
	override func vellum(iden: UUID) -> Vellum? {
		guard let acnt = acnt else {return nil}
		let rows = query("SELECT * FROM vellum WHERE acnt = '\(acnt)' AND iden = '\(iden)'")
		guard rows.count == 1 else {return nil}
		let attributes = rows[0]
		return toVellum(attributes: attributes)
	}
	override func vellum(type: String, only: String) -> Vellum? {
		return nil
	}
}
