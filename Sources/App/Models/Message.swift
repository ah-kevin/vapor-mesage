//
//  Message.swift
//  messages
//
//  Created by 柯秉钧 on 2017/5/11.
//
//

import Foundation
import Vapor
import Fluent

struct Message {
	var exists: Bool = false

	// Model必须实现"id"属性
	var id: Node?
	var messageId: String;
	let threadId: Int;
	let participantId: Int;
	let text: String;
	let timestamp: Int;

	init(messageId: String, threadId: Int, participantId: Int, text: String) {
		self.messageId = messageId
		self.threadId = threadId
		self.participantId = participantId
		self.text = text
		self.timestamp = Int(Date().timeIntervalSince1970)
	}
}

extension Message: Model {
	// Node Initializable 将持久化存储数据创建为model的方法
	init(node: Node, in context: Context) throws {
		id = try node.extract("id")
		messageId = try node.extract("messageId")
		threadId = try node.extract("threadId")
		participantId = try node.extract("participantId")
		text = try node.extract("text")
		timestamp = Int(Date().timeIntervalSince1970)
	}

	// NodeRepresentable 将模型保存到数据库中
	func makeNode(context: Context) throws -> Node {
		return try Node(node: [
			"id": id,
			"messageId": messageId,
			"threadId": threadId,
			"participantId": participantId,
			"text": text,
			"timestamp": timestamp
		])
	}
}

extension Message: Preparation {
	static func prepare(_ database: Database) throws {
		try database.create("messages", closure: { (participants) in
			participants.id()
			participants.string("messageId")
			participants.int("threadId")
			participants.int("participantId")
			participants.string("text")
			participants.int("timestamp")
		})
	}
	static func revert(_ database: Database) throws {
		try database.delete("messages")
	}
}
