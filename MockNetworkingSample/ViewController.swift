//
//  ViewController.swift
//  MockNetworkingSample
//
//  Created by KoingDev on 3/12/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let viewModel = TodoViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.getAllTodos { [weak self] success in
			guard let s = self else { return }
			s.viewModel.todos.forEach { print($0) }
		}
	}


}

