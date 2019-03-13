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

final class MockTodoNetworkService: TodoNetworkServiceType {
	
	// These are properties we use to fake the response
	var status: ResponseStatus!
	var todos: [Todo]!
	
	func fakeResponse(status: ResponseStatus, todos: [Todo]?) {
		self.status = status
		self.todos = todos
	}
	
	func getAllTodos(completion: @escaping (ResponseStatus, [Todo]?) -> Void) {
		completion(status, todos)
	}
	
}

class MockNetworkingSampleTests: XCTestCase {

	let mockTodoNetworkService = MockTodoNetworkService()
	
	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

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

}
