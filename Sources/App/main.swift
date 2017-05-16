import Vapor
import VaporMySQL
import Foundation

let drop = Droplet()

try drop.addProvider(VaporMySQL.Provider.self)

// 数据库
drop.preparations = [Participant.self, Message.self, Thread.self, User.self]

// MARK: - threads
drop.resource("api/threads", ThreadController())
drop.resource("api/participant", ParticipantController())
drop.resource("api/message", MessageController())

drop.run()
