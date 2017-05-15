//
//  ParticipantController.swift
//  messages
//
//  Created by 柯秉钧 on 2017/5/15.
//
//
import Foundation
import HTTP
import Vapor

final class ParticipantController: ResourceRepresentable {
	func index(request: Request) throws -> ResponseRepresentable {
		return try Participant.all().makeNode().converted(to: JSON.self)
	}
	func show(request: Request, participant: Participant) throws -> ResponseRepresentable {
		return participant
	}
	func create(request: Request) throws -> ResponseRepresentable {
		var participant = try request.participant();
		try participant.save()
		return participant

	}
	func makeResource() -> Resource<Participant> {
		return Resource(
			index: index,
			store: create,
			show: show
		)
	}
}

extension Request {
	func participant() throws -> Participant {
		guard let json = json else {
			throw Abort.badRequest
		}
		return try Participant(node: json)
	}
}
