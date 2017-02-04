import XCTest
import SwiftDIHLP
@testable import SwiftDIWebRepositories

class InMemoryGameRepositoryTests: GameRepositoryTests {

    static var allTests: [(String, (InMemoryGameRepositoryTests) -> () throws -> Void)] {
        return [
            ("testSave_callsTheCompletionWithTheSavedGames", testSave_callsTheCompletionWithTheSavedGames),
            ("testFetchGames_whenThereAreNoSavedGames_callsTheCompletionWithEmptyArray", testFetchGames_whenThereAreNoSavedGames_callsTheCompletionWithEmptyArray),
            ("testFetchGames_whenThereIsASavedGame_callsTheCompletionWithTheGame", testFetchGames_whenThereIsASavedGame_callsTheCompletionWithTheGame),
            ("testFetchGameById_whenThereIsNoGameWithThatId_callsTheCompletionWithNil", testFetchGameById_whenThereIsNoGameWithThatId_callsTheCompletionWithNil),
            ("testFetchGameById_whenThereIsAGameWithTheId_callsTheCompletionWithTheFetchedGame", testFetchGameById_whenThereIsAGameWithTheId_callsTheCompletionWithTheFetchedGame)
        ]
    }

    override func setUp() {
        gameRepository = InMemoryGameRepository()
        super.setUp()
    }

}
