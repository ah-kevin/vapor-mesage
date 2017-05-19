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
		if request.headers["userId"] != nil {
			let userId = request.headers["userId"]!.string!

			let messagesForUserId = try Message.database?.driver.raw("select * from `messages` where `messages`.`threadId` in (select DISTINCT `messages`.`threadId` from `messages` where participantId = \(userId))")
			let participants = try Participant.database?.driver.raw("SELECT * FROM `participants` WHERE `participants`.`id` in (SELECT DISTINCT `messages`.`participantId` FROM `messages` WHERE `messages`.`threadId` in (SELECT DISTINCT `messages`.`threadId` FROM `messages` WHERE `messages`.`participantId`=\(userId)))")
			let threadsNode = try Message.database?.driver.raw("select DISTINCT `messages`.`threadId` from `messages` where participantId = \(userId)")

			let threadsIds = try threadsNode!.extract("threadId") as [Int]

			var threads: [Thread] = []
			for threadId in threadsIds {
				threads.append(Thread(threadId: threadId))
			}
			let nodes = try threads.map({ (thread) -> Node in
				return try thread.makeResponseNode()
			})
			return try JSON(node: [
				"participants": participants?.makeNode(),
				"messages": messagesForUserId?.makeNode(),
				"threads": nodes.makeNode(),
			])
		} else {
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
	}

	func show(request: Request, thread: Thread) throws -> ResponseRepresentable {
		let id = thread.threadId;
		let thread = try thread.makeResponseNode()
		let data = try thread.extract("participants") as [String: Int]
		var participants: [Participant] = []
		var messages: [Message] = []
		for participantId in data.keys {
			participants.append(try Participant.query().filter("id", participantId).first()!)
		}

		messages = try Message.query().filter("threadId", id).all()

		return try JSON(node: [
			"threads": thread.makeNode(),
			"participants": participants.makeNode(),
			"messages": messages.makeNode()
		])

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
