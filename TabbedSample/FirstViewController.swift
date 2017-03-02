//
//  FirstViewController.swift
//  TabbedSample
//
//  Created by Niall Quinn on 02/03/2017.
//  Copyright © 2017 popdeem. All rights reserved.
//

import UIKit
import PopdeemKit


class FirstViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func showPopdeem() {
		PopdeemSDK.presentHome(toNavigationController: self.navigationController!)
	}


}

