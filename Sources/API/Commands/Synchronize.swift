//
//  Synchronize.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

class Synchronize: Command {
	init () {
		super.init(method: .post, path: "/synchronize")
	}
	
// Command =========================================================================================
	override func execute (params: [String:String], attributes: [String:Any], device: Device, account: Account, codex: Codex) -> [String:Any] {
		var sb: String = "[synchronize]"
		defer {Log.print(sb)}
		
		let documents = attributes["documents"] as! [[String:Any]]
		let deleted = attributes["deleted"] as! [[String:Any]]
		let memories = attributes["memories"] as! [[String:Any]]

		let oldFork = attributes["fork"] as! Int
		let newFork = account.fork+1
		
		var uncommitted = false
		var unbroken = false
		if oldFork != device.fork {
			uncommitted = true
			if device.token == account.token && oldFork >= account.since {
				unbroken = true
			}
		}
		
		sb += " received: \(documents.count)"

		var holdVellums = [Vellum]()
		for var attributes in documents {
			let uuid = UUID(uuidString: attributes["iden"] as! String)!
			var vellum: Vellum? = codex.selectByID(uuid)
			
			if let vellum = vellum {
				if (vellum.vers == attributes["vers"] as! Int) || unbroken {
					attributes["fork"] = newFork
					attributes["vers"] = vellum.vers + 1
				} else if let resolver = Vellum.resolver(for: vellum.type) {
					var attributes = resolver.resolve(old: vellum.attributes, new: attributes, uncommitted: uncommitted)
					attributes["fork"] = newFork
					attributes["vers"] = vellum.vers + 1
				}
				vellum.attributes = attributes
				holdVellums.append(vellum)
			} else {
				let type = attributes["type"] as! String
				if let onlyTag = Vellum.resolver(for: type)?.only {
					let only = attributes[onlyTag] as! String
					vellum = codex.selectBy(type: type, only: only)
				}
				
				if vellum == nil {
					attributes["fork"] = newFork
					attributes["vers"] = 1
					vellum = Vellum(acnt: account.acnt, born: newFork, attributes: attributes)
					vellum!.born = newFork
					holdVellums.append(vellum!)
				} else {
				}
			}
		}
		codex.holdVellums = holdVellums

		var holdDeleted = [Vellum]()
		for attributes in deleted {
			let uuid = UUID(uuidString: attributes["iden"] as! String)!
			guard let vellum = codex.selectByID(uuid) else {continue}
			vellum.gone = newFork
			holdDeleted.append(vellum)
		}
		codex.holdDeleted = holdDeleted
		
		var holdMemories = [Memory]()
		for attributes in memories {
			let name: String = attributes["name"] as! String
			let value: String = attributes["value"] as! String
			let vers: Int = 1
			let born = newFork
			let gone: Int? = nil
			
			let memory: Memory = codex.memory(name: name) ?? {
				return Memory(acnt: account.acnt, name: name, value: value, vers: vers, fork: newFork, born: born, gone: gone)
			}()
			memory.value = value
			holdMemories.append(memory)
		}
		codex.holdMemories = holdMemories
		
		var echo = [String:Any]()
		
		let echoes = codex.echoPacket(oldFork)

		if echoes.count > 0 {
			echo["fork"] = newFork
			echo["documents"] = echoes
			sb += ", echoed: \(echoes.count)"
		} else {
			sb += ", echoed: 0"
		}
		
		if codex.hasHolds {
			sb += ", fork \(newFork) queued"
		}
		
		if uncommitted {
			var sb2: String = "[previous commit failed]"
			defer {print(sb2)}
			if unbroken {
				sb2 += " but chain was unbroken"
			}
		}
		
		return echo
	}
}
