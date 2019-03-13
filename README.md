# MockNetworkingSample
Unit Testing by mocking a network response + Nimble including with a quick MVVM Concept

> Why should we mock Networking Layer while writing a test ?
- To simulate different scenarios
- The test stop depending on the Network Condition
- No more server communication
- Flexibility to write a test in various situations that may not be so easy to reproduce if we write a test that talk to a real server

#### Sample test code written in this project using _Nimble Framework_ and _[Given, When, Then] Pattern_

```swift
func testGetAllTodosSuccess() {
  // Given
  var result: Bool = false
  let fakeTodos: [Todo] = [
    Todo(userId: 1, id: 1, title: "K1", completed: true),
    Todo(userId: 1, id: 2, title: "K2", completed: true),
  ]
  mockTodoNetworkService.fakeResponse(status: .success, todos: fakeTodos)

  // When
  let viewModel = TodoViewModel(todoNetworkService: mockTodoNetworkService)
  viewModel.getAllTodos { success in
    result = success
  }

  // Then
  expect(result).toEventually(beTrue())
  expect(viewModel.todos?[0].title).toEventually(equal("K1"))
}

func testGetAllTodosFail() {
  // Given
  var result: Bool = false
  let fakeTodos: [Todo]? = nil
  mockTodoNetworkService.fakeResponse(status: .fail, todos: fakeTodos)

  // When
  let viewModel = TodoViewModel(todoNetworkService: mockTodoNetworkService)
  viewModel.getAllTodos { success in
    result = success
  }

  // Then
  expect(result).toEventually(beFalse())
  expect(viewModel.todos).toEventually(beNil())
}

func testGetAllTodosSuccessWithEmptyResult() {
  // Given
  var result: Bool = false
  let fakeTodos: [Todo] = []
  mockTodoNetworkService.fakeResponse(status: .success, todos: fakeTodos)

  // When
  let viewModel = TodoViewModel(todoNetworkService: mockTodoNetworkService)
  viewModel.getAllTodos { success in
    result = success
  }

  // Then
  expect(result).toEventually(beTrue())
  expect(viewModel.todos).toEventually(beEmpty())
}
```
