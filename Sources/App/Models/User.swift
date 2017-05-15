//
//  User.swift
//  messages
//
//  Created by 柯秉钧 on 2017/5/14.
//
//

import Foundation
import Vapor
import Fluent

struct User {
	var exists: Bool = false

	var id: Node?
	var firstName: String
	var lastName: String
	var email: String
	var password: String

	init(firstName: String, lastName: String, email: String, password: String) {
		self.firstName = firstName
		self.lastName = lastName
		self.email = email
		self.password = password
	}

	func makeResponseNode() throws -> Node {
		return try Node(node: [
			"id": id,
			"first_name": firstName,
			"last_name": lastName,
			"email": email,
		])
	}

}

extension User: Model {
	// Node Initializable 将持久化存储数据创建为model的方法
	init(node: Node, in context: Context) throws {
		id = try node.extract("id")
		firstName = try node.extract("first_name")
		lastName = try node.extract("last_name")
		email = try node.extract("email")
		password = try node.extract("password")
	}
	// NodeRepresentable 将模型保存到数据库中
	func makeNode(context: Context) throws -> Node {
		return try Node(node: [
			"id": id,
			"first_name": firstName,
			"last_name": lastName,
			"email": email,
			"password": password
		])
	}
}

extension User: Preparation {
	static func prepare(_ database: Database) throws {
		try database.create("users", closure: { (users) in
			users.id()
			users.string("first_name")
			users.string("last_name")
			users.string("email")
			users.string("password")
		})
	}

	static func revert(_ database: Database) throws {
		try database.delete("users")
	}
}
