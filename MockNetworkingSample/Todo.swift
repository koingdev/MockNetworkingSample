//
//  Todo.swift
//  MockNetworkingSample
//
//  Created by KoingDev on 3/12/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation

////////////////////////////////////////////////////////////////
//
// MODEL: A simple entity which represents real world object
//
////////////////////////////////////////////////////////////////

struct Todo: Codable {
	
	var userId: Int
	var id: Int
	var title: String
	var completed: Bool
	
	init(userId: Int, id: Int, title: String, completed: Bool) {
		self.userId = userId
		self.id = id
		self.title = title
		self.completed = completed
	}
	
}
