//
//  ThreadController.swift
//  messages
//
//  Created by 柯秉钧 on 2017/5/15.
//
//
import Foundation
import HTTP
import Vapor

final class ThreadController: ResourceRepresentable {
	func index(request: Request) throws -> ResponseRepresentable {
		let nodes = try Thread.all().map({ (thread) -> Node in
			return try thread.makeResponseNode()
		})
		let participants = try Participant.all()
		let messages = try Message.all()

		return try JSON(node: [
			"threads": nodes.makeNode(),
			"participants": participants.makeNode(),
			"messages": messages.makeNode()
		])
	}

	func show(request: Request, thread: Thread) throws -> ResponseRepresentable {
		return try thread.makeResponseNode().converted(to: JSON.self)
	}

	func create(request: Request) throws -> ResponseRepresentable {
		var thread = try request.thread();
		try thread.save()
		return thread

	}
	func makeResource() -> Resource<Thread> {
		return Resource(
			index: index,
			store: create,
			show: show
		)
	}
}

extension Request {
	func thread() throws -> Thread {
		guard let json = json else {
			throw Abort.badRequest
		}
		return try Thread(node: json)
	}
}
