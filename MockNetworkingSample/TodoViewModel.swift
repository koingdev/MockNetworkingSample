//
//  TodoViewModel.swift
//  MockNetworkingSample
//
//  Created by KoingDev on 3/12/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation

final class TodoViewModel {
	
	let webService: WebServiceType
	var todos: [Todo]!
	
	// Inject Dependencies here
	init(webService: WebServiceType = WebService()) {
		self.webService = webService
	}
	
	func getAllTodos(completion: @escaping (Bool) -> Void) {
		webService.getAllTodos { status, todos in
			switch status {
			case .success:
				// does something here for success...
				self.todos = todos
				completion(true)
			case .fail:
				// does something here for fail...
				self.todos = []
				completion(false)
			}
		}
	}
	
}
