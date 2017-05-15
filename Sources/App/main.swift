import Vapor
import VaporMySQL
import Foundation

let drop = Droplet()

try drop.addProvider(VaporMySQL.Provider.self)

// 数据库
drop.preparations = [Participant.self, Message.self, Thread.self, User.self]

// MARK: - threads
drop.resource("threads", ThreadController())
drop.resource("participant", ParticipantController())
drop.resource("message", MessageController())

drop.run()
