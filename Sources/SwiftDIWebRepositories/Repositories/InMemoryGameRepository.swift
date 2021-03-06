import SwiftDIHLP
import Foundation

public class InMemoryGameRepository: GameRepository {
    var games: [Game] = []

    public init() {}

    public func save(game: Game, completion: @escaping SaveGameCompletion) {
        let savedGame = Game(p1: game.p1, p2: game.p2, result: game.result, id: UUID())
        games.append(savedGame)
        completion(savedGame)
    }

    public func fetch(completion: @escaping FetchGamesCompletion) {
        completion(games)
    }

    public func fetch(id: UUID, completion: @escaping FetchGameCompletion) {
        completion(games.filter({$0.id! == id}).first)
    }

    public func deleteAll() {
        games = []
    }
}
