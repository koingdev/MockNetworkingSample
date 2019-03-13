//
//  TodoViewModel.swift
//  MockNetworkingSample
//
//  Created by KoingDev on 3/12/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation

////////////////////////////////////////////////////////////////
//
// VIEWMODEL RESPONSIBILITIES:
//		* Take care of App Logics
//		* Use other dependencies (Ex: NetworkService, Database...) to perform some operation
//		* Notify ViewController when something done via callback, delegate, binding...
//
////////////////////////////////////////////////////////////////

final class TodoViewModel {
	
	let todoNetworkService: TodoNetworkServiceType
	var todos: [Todo]?
	
	// Inject Dependencies here
	init(todoNetworkService: TodoNetworkServiceType = TodoNetworkService()) {
		self.todoNetworkService = todoNetworkService
	}
	
	func getAllTodos(completion: @escaping (Bool) -> Void) {
		todoNetworkService.getAllTodos { status, todos in
			self.todos = todos
			
			switch status {
			case .success:
				// does something here for success...
				completion(true)
			case .fail:
				// does something here for fail...
				completion(false)
			}
		}
	}
	
}
