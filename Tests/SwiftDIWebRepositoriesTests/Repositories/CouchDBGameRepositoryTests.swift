import XCTest
import SwiftDIHLP
@testable import SwiftDIWebRepositories

class CouchDBGameRepositoryTests: GameRepositoryTests {

    override func setUp() {
        gameRepository = CouchDBGameRepository()
        super.setUp()
    }

}
