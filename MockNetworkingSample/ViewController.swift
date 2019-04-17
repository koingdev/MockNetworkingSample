//
//  ViewController.swift
//  MockNetworkingSample
//
//  Created by KoingDev on 3/12/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

////////////////////////////////////////////////////////////////
//
// VIEW RESPONSIBILITIES:
//		* Take care of all UI-related stuff
//		* Use ViewModel to get something done
//
////////////////////////////////////////////////////////////////

class ViewController: UIViewController {

	let viewModel = TodoViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.getAllTodos { [weak self] success in
			guard let s = self else { return }
			s.viewModel.todos.map { $0.forEach { print($0) } }
		}
	}

}

