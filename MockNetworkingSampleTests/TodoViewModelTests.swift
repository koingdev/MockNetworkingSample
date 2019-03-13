//
//  MockNetworkingSampleTests.swift
//  MockNetworkingSampleTests
//
//  Created by KoingDev on 3/12/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import XCTest
import Nimble

@testable import MockNetworkingSample

////////////////////////////////////////////////////////////////
//
// Why should we mock Networking Layer while writing a test ?
//		* To simulate different scenarios
//		* The test stop depending on the Network Condition
//		* No more server communication
//		* Flexibility to write a test in various situations
//		that may not be so easy to reproduce if we write a test that talk to a real server
//
////////////////////////////////////////////////////////////////

class TodoViewModelTests: XCTestCase {

  // MARK: - Private Properties

  private var sut: TodoViewModel!

  private var mockTodoNetworkService: MockTodoNetworkService!
  private var fakeTodos: [Todo] = []

  // MARK: - Lifecycle
	
	override func setUp() {
    super.setUp()

    mockTodoNetworkService = MockTodoNetworkService()
    sut = TodoViewModel(todoNetworkService: mockTodoNetworkService)
}

	override func tearDown() {
    super.tearDown()

    mockTodoNetworkService = nil
    sut = nil
	}

  // MARK: - Tests

	func test_getAllTodos_whenResponseIsSuccess_shouldReturnTodos() {
		// Given
		var result: Bool = false
		fakeTodos = [
			Todo(userId: 1, id: 1, title: "K1", completed: true),
			Todo(userId: 1, id: 2, title: "K2", completed: true),
		]
		mockTodoNetworkService.fakeResponse(status: .success, todos: fakeTodos)
		
		// When
		sut.getAllTodos { success in
			result = success
		}
		
		// Then
		expect(result).toEventually(beTrue())
		expect(self.sut.todos?.first?.title).toEventually(equal("K1"))
	}
	
	func test_getAllTodos_whenResponseIsFail_shouldReturnNil() {
		// Given
		var result: Bool = false
		mockTodoNetworkService.fakeResponse(status: .fail, todos: nil)
		
		// When
		sut.getAllTodos { success in
			result = success
		}
		
		// Then
		expect(result).toEventually(beFalse())
		expect(self.sut.todos).toEventually(beNil())
	}
	
	func testGetAllTodosSuccessWithEmptyResult() {
		// Given
		var result: Bool = false
		mockTodoNetworkService.fakeResponse(status: .success, todos: fakeTodos)
		
		// When
		sut.getAllTodos { success in
			result = success
		}
		
		// Then
		expect(result).toEventually(beTrue())
		expect(self.sut.todos).toEventually(beEmpty())
	}

}

// MARK: - Mocks

extension TodoViewModelTests {

  private class MockTodoNetworkService: TodoNetworkServiceType {

    // These are properties we use to fake the response
    private(set) var status: ResponseStatus!
    private(set) var todos: [Todo]!

    func fakeResponse(status: ResponseStatus, todos: [Todo]?) {
      self.status = status
      self.todos = todos
    }

    func getAllTodos(completion: @escaping (ResponseStatus, [Todo]?) -> Void) {
      completion(status, todos)
    }

  }
}
