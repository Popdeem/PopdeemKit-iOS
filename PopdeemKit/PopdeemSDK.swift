//
//  PopdeemSDK.swift
//  PopdeemKit
//
//  Created by Niall Quinn on 02/03/2017.
//  Copyright © 2017 popdeem. All rights reserved.
//

import Foundation

class PopdeemSDK: NSObject {
	static let shared = PopdeemSDK()
	let apiKey: String!
	let baseUrl: URL!
	
	init?() {
		guard let path = Bundle.main.path(forResource: "Popdeem", ofType: "plist") else {
			NSLog("Error: Popdeem.plist not found in bundle")
			return nil
		}
		guard let myDict = NSDictionary(contentsOfFile: path) else {
			NSLog("Error: Contents of Popdeem.plist not a Dictionary")
			return nil
		}
		guard let _apiKey: String = myDict["apiKey"] as! String! else {
			NSLog("Error: No value for key \"apiKey\" in Popdeem.plist")
			return nil
		}
		guard let _urlStr: String = myDict["baseUrl"] as! String! else {
			NSLog("Error: No value for key \"baseUrl\" in Popdeem.plist")
			return nil
		}
		apiKey = _apiKey
		baseUrl = URL(string: _urlStr)
	}
	
	static func presentHome(toNavigationController controller: UINavigationController) {
		self.class.presentHome(toNavigationController: controller, animated: true)
	}
	
	static func presentHome(toNavigationController controller: UINavigationController, animated: Bool) {
		
	}

}
