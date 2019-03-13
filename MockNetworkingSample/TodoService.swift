//
//  WebService.swift
//  MockNetworkingSample
//
//  Created by KoingDev on 3/12/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation
import Alamofire

////////////////////////////////////////////////////////////////
//
// NETWORK LAYER RESPONSIBILITIES:
//		* Talk to Server
//		* Return response within completion block
//
// NOTE: Some people might come up with different naming-convention
// 		 like XXXService, XXXManager, XXXModelAction
//		 So just don't care about the naming
////////////////////////////////////////////////////////////////

enum ResponseStatus {
	case success
	case fail
}

protocol TodoServiceType {
	func getAllTodos(completion: @escaping (ResponseStatus, [Todo]?) -> Void)
	// More operation here...
}

final class TodoService: TodoServiceType {
	
	func getAllTodos(completion: @escaping (ResponseStatus, [Todo]?) -> Void) {
		Alamofire.request("https://jsonplaceholder.typicode.com/todos")
			.validate()
			.responseData { response in
				guard response.error == nil else {
					// Fail
					completion(.fail, nil)
					return
				}
				// Success
				guard let data = response.data else {
					completion(.success, [])
					return
				}
				let todos = try! JSONDecoder().decode([Todo].self, from: data)
				completion(.success, todos)
			}
	}
	
}
