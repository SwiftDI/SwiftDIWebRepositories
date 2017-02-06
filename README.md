# SwiftDIWebRepositories

A library of repositories for use in server-side Swift apps that use the `SwiftDIHLP` high-level policy module.

## Installation

- If you haven't installed `SwiftDIWebRepositories` as part of the `SwiftDI` project, clone it locally:

    ```bash
    $ git clone https://github.com/alexbasson/SwiftDIWebRepositories.git
    $ cd SwiftDIWebRepositories
    $ swift build
    ```

- Generate an `.xcodeproj` file for local development:

    ```bash
    $ swift package generate-xcodeproj
    ```


## Building

From the command line:

```bash
$ swift build
```

From Xcode: `Cmd-B`.

## Testing

From the command line:

```bash
$ swift test
```

From Xcode: `Cmd-U`.

## Test-driving A New Repository

Repositories implement the `GameRepository` protocol from the `SwiftDIHLP` module. `SwiftDIHLP` also defines a set of tests for repository implementations. A new repository need only pass these tests to satisfy the needs of `SwiftDIHLP`-based apps.

To create the tests for a new repository, say `MyNewRepository`, create a new unit test case class for `MyNewRepository`:

```swift
import XCTest
import SwiftDIHLP
@testable import SwiftDIWebRepositories

class MyNewRepositoryTests: GameRepositoryTests {

    static var allTests: [(String, (MyNewRepositoryTests) -> () throws -> Void)] {
        return [
            ("testSave_callsTheCompletionWithTheSavedGames", testSave_callsTheCompletionWithTheSavedGames),
            ("testFetchGames_whenThereAreNoSavedGames_callsTheCompletionWithEmptyArray", testFetchGames_whenThereAreNoSavedGames_callsTheCompletionWithEmptyArray),
            ("testFetchGames_whenThereIsASavedGame_callsTheCompletionWithTheGame", testFetchGames_whenThereIsASavedGame_callsTheCompletionWithTheGame),
            ("testFetchGameById_whenThereIsNoGameWithThatId_callsTheCompletionWithNil", testFetchGameById_whenThereIsNoGameWithThatId_callsTheCompletionWithNil),
            ("testFetchGameById_whenThereIsAGameWithTheId_callsTheCompletionWithTheFetchedGame", testFetchGameById_whenThereIsAGameWithTheId_callsTheCompletionWithTheFetchedGame)
        ]
    }

    override func setUp() {
        gameRepository = MyNewRepository()
        super.setUp()
    }

}
```

That's it! `GameRepositoryTests` defines all the tests cases necessary for the new repository to pass.
