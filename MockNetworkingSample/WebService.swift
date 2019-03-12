//
//  WebService.swift
//  MockNetworkingSample
//
//  Created by KoingDev on 3/12/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation

enum ResponseStatus {
	case success
	case fail
}

protocol WebServiceType {
	
	var responseStatus: ResponseStatus { set get }
	
	func getAllTodos(completion: @escaping (ResponseStatus, [Todo]) -> Void)
	// More operation here...
	
}

final class WebService: WebServiceType {
	
	private var task: URLSessionDataTask?
	var responseStatus: ResponseStatus = .fail
	
	func getAllTodos(completion: @escaping (ResponseStatus, [Todo]) -> Void) {
		let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
		let session = URLSession.shared
		task = session.dataTask(with: url) { data, response, error in
			guard let data = data else {
				// Fail
				self.responseStatus = .fail
				completion(self.responseStatus, [])
				return
			}
			// Success
			self.responseStatus = .success

			let todos = try! JSONDecoder().decode([Todo].self, from: data)
			completion(self.responseStatus, todos)
		}
		task?.resume()
	}
	
}
