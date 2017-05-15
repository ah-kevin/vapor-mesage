//
//  UserController.swift
//  messages
//
//  Created by 柯秉钧 on 2017/5/14.
//
//

import HTTP
import Vapor
final class UserController: ResourceRepresentable {
	// get users
	func index(request: Request) throws -> ResponseRepresentable {
		let nodes = try User.all().map({ (user) -> Node in
			return try user.makeResponseNode()
		})
		return try nodes.makeNode().converted(to: JSON.self)

	}
	// get users/:id
	func show(request: Request, user: User) throws -> ResponseRepresentable {
//		return user
		return try user.makeResponseNode().converted(to: JSON.self)
	}

	// {delete} /users/:id
	func delete(request: Request, user: User) throws -> ResponseRepresentable {
		try user.delete()
		return try JSON(node: [
			"code": "1",
			"success": "成功"
		])
	}

	func create(request: Request) throws -> ResponseRepresentable {
		var user = try request.user()
		try user.save()
		return user

	}

	func update(request: Request, user: User) throws -> ResponseRepresentable {
		let new = try request.user()
		var user = user
		user.firstName = new.firstName
		try user.save()
		return user
	}

	func makeResource() -> Resource<User> {
		return Resource(
			index: index,
			store: create,
			show: show,
			modify: update,
			destroy: delete
		)
	}
}

extension Request {
	func user() throws -> User {
		guard let json = json else { throw Abort.badRequest }
		return try User(node: json)
	}
}
