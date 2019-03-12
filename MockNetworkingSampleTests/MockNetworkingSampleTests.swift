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

final class MockWebService: WebServiceType {
	
	// These are properties we use to fake the response
	var responseStatus: ResponseStatus = .fail
	var todos: [Todo]!
	
	func fakeResponse(status: ResponseStatus, todos: [Todo]) {
		responseStatus = status
		self.todos = todos
	}
	
	func getAllTodos(completion: @escaping (ResponseStatus, [Todo]) -> Void) {
		completion(responseStatus, todos)
	}
	
}

class MockNetworkingSampleTests: XCTestCase {

	let mockWebService = MockWebService()
	
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
		mockWebService.fakeResponse(status: .success, todos: fakeTodos)
		
		
		// When
		let viewModel = TodoViewModel(webService: mockWebService)
		viewModel.getAllTodos { success in
			result = success
		}
		
		// Then
		expect(result).toEventually(beTrue())
		expect(viewModel.todos[0].title).toEventually(equal("K1"))
	}
	
	func testGetAllTodosFail() {
		// Given
		var result: Bool = false
		let fakeTodos: [Todo] = []
		mockWebService.fakeResponse(status: .fail, todos: fakeTodos)
		
		// When
		let viewModel = TodoViewModel(webService: mockWebService)
		viewModel.getAllTodos { success in
			result = success
		}
		
		// Then
		expect(result).toEventually(beFalse())
		expect(viewModel.todos).toEventually(beEmpty())
	}
	
	func testGetAllTodosSuccessWithEmptyResult() {
		// Given
		var result: Bool = false
		let fakeTodos: [Todo] = []
		mockWebService.fakeResponse(status: .success, todos: fakeTodos)
		
		// When
		let viewModel = TodoViewModel(webService: mockWebService)
		viewModel.getAllTodos { success in
			result = success
		}
		
		// Then
		expect(result).toEventually(beTrue())
		expect(viewModel.todos).toEventually(beEmpty())
	}

}
