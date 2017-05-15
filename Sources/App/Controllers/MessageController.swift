//
//  MessageController.swift
//  messages
//
//  Created by 柯秉钧 on 2017/5/15.
//
//
import Foundation
import HTTP
import Vapor

final class MessageController: ResourceRepresentable {

	func index(request: Request) throws -> ResponseRepresentable {
		return try Message.all().makeNode().converted(to: JSON.self)
	}

	func show(request: Request, message: Message) throws -> ResponseRepresentable {
		return message
	}

	func create(request: Request) throws -> ResponseRepresentable {
		var message = try request.message();
		try message.save()
		return message

	}
	func makeResource() -> Resource<Message> {
		return Resource(
			index: index,
			store: create,
			show: show
		)
	}
}

extension Request {
	func message() throws -> Message {
		guard let json = json else {
			throw Abort.badRequest
		}
		return try Message(node: json)
	}
}
