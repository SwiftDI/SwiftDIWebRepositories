import SwiftDIHLP
import Foundation
import CouchDB
import SwiftyJSON

extension Game {
    func toDict() -> [String: String] {
        var dict = [
            "p1": p1,
            "p2": p2,
            "result": result.rawValue,
        ]
        if let id = id {
            dict["uuid"] = id.uuidString
        }
        return dict
    }
}

public class CouchDBGameRepository: GameRepository {
    let client: CouchDBClient
    var database: Database? = nil

    public init() {
        let connectionProperties = ConnectionProperties(host: "localhost", port: 5984, secured: false)
        client = CouchDBClient(connectionProperties: connectionProperties)
        createDatabase()
    }

    public func save(game: Game, completion: @escaping SaveGameCompletion) {
        guard let database = database else { return }
        let savedGame = Game(p1: game.p1, p2: game.p2, result: game.result, id: UUID())
        let json = JSON(savedGame.toDict())
        database.create(json) {
            id, revision, doc, error in
            completion(savedGame)
        }
    }

    public func fetch(completion: @escaping FetchGamesCompletion) {
        guard let database = database else { return }
        database.retrieveAll(includeDocuments: true) { (docs, error) in
            if let docs = docs {
                var games: [Game] = []
                for document in docs["rows"].arrayValue {
                    let uuidString = document["doc"]["uuid"].stringValue
                    let p1 = document["doc"]["p1"].stringValue
                    let p2 = document["doc"]["p2"].stringValue
                    let resultString = document["doc"]["result"].stringValue
                    if let result = GameResult(rawValue: resultString) {
                        let game = Game(p1: p1, p2: p2, result: result, id: UUID(uuidString: uuidString))
                        games.append(game)
                    }
                }
                completion(games)
            }
        }
    }

    public func fetch(id: UUID, completion: @escaping FetchGameCompletion) {
        guard let database = database else { return }
        database.retrieveAll(includeDocuments: true) { (docs, error) in
            if let docs = docs {
                if let gameJSON = docs["rows"].arrayValue.filter({$0["doc"]["uuid"].stringValue == id.uuidString}).first {
                    let p1 = gameJSON["doc"]["p1"].stringValue
                    let p2 = gameJSON["doc"]["p2"].stringValue
                    let resultString = gameJSON["doc"]["result"].stringValue
                    let uuidString = gameJSON["doc"]["uuid"].stringValue
                    if let result = GameResult(rawValue: resultString) {
                        let game = Game(p1: p1, p2: p2, result: result, id: UUID(uuidString: uuidString))
                        completion(game)
                    }
                }
            }
        }
    }

    public func deleteAll() {
        createDatabase()
    }

    private func createDatabase() {
        if let database = database {
            client.deleteDB(database) { (error) in
            }
        }
        client.createDB("games") { (database, error) in
            if let database = database {
                self.database = database
            } else {
                self.database = self.client.database("games")
            }
        }
    }
}
