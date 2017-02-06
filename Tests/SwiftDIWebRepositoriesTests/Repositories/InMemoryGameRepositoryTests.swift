import XCTest
import SwiftDIHLP
@testable import SwiftDIWebRepositories

class InMemoryGameRepositoryTests: GameRepositoryTests {

    override func setUp() {
        gameRepository = InMemoryGameRepository()
        super.setUp()
    }

}
