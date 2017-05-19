//
//  Thread.swift
//  messages
//
//  Created by 柯秉钧 on 2017/5/11.
//
//

import Foundation
import Vapor
import Fluent
import HTTP
struct Thread {
	var exists: Bool = false

	// Model必须实现"id"属性
	var id: Node?
	var threadId: Int

	init(threadId: Int) {
		self.threadId = threadId
	}

	func makeResponseNode() throws -> Node {
		let messages = try Message.query().filter("threadId", threadId).all()
		var messageIds: [Int] = []
		var participants: Set<Int> = []
		var participantsId = [String: Int]()
		for message in messages {
			messageIds.append(try Int(node: message.id))
			participants.insert(message.participantId)
		}
		for (_, id) in participants.sorted().enumerated() {
			participantsId.updateValue(0, forKey: String(id))
		}
		return try Node(node: [
			"id": threadId.makeNode(),
			"messageIds": messageIds.makeNode(),
			"participants": participantsId.makeNode(),
		])
	}

}

extension Thread: Model {
	// Node Initializable 将持久化存储数据创建为model的方法
	init(node: Node, in context: Context) throws {
		id = try node.extract("id")
		threadId = try node.extract("threadId")
	}

	// NodeRepresentable 将模型保存到数据库中
	func makeNode(context: Context) throws -> Node {
		return try Node(node: [
			"id": id,
			"threadId": threadId
		])
	}
}

extension Thread: Preparation {
	static func prepare(_ database: Database) throws {
		try database.create("threads", closure: { (participants) in
			participants.id()
			participants.int("threadId")

		})
	}
	static func revert(_ database: Database) throws {
		try database.delete("threads")
	}
}

