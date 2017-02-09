import XCTest
import SwiftDIHLP
@testable import SwiftDIWebRepositories

class CouchDBGameRepositoryTests: GameRepositoryTests {

    override func setUp() {
        gameRepository = CouchDBGameRepository()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        guard let gameRepository = gameRepository else { return }
        gameRepository.deleteAll()
    }

}
