//
//  participants.swift
//  messages
//
//  Created by 柯秉钧 on 2017/5/11.
//
//

import Foundation
import Vapor
import Fluent

struct Participant {
	var exists: Bool = false

	// Model必须实现"id"属性
	var id: Node?

	let name: String

	init(name: String) {
		self.name = name
	}
}

extension Participant: Model {
	// Node Initializable 将持久化存储数据创建为model的方法
	init(node: Node, in context: Context) throws {
		id = try node.extract("id")
		name = try node.extract("name")
	}

	// NodeRepresentable 将模型保存到数据库中
	func makeNode(context: Context) throws -> Node {
		return try Node(node: [
			"id": id,
			"name": name
		])
	}
}

extension Participant: Preparation {
	static func prepare(_ database: Database) throws {
		try database.create("participants", closure: { (participants) in
			participants.id()
			participants.string("name")
		})
	}
	static func revert(_ database: Database) throws {
		try database.delete("participants")
	}
}
