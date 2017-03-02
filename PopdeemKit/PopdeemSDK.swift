//
//  PopdeemSDK.swift
//  PopdeemKit
//
//  Created by Niall Quinn on 02/03/2017.
//  Copyright © 2017 popdeem. All rights reserved.
//

import Foundation

public class PopdeemSDK: NSObject {
	
	private static var sharedSDK: PopdeemSDK = {
		let sdk = PopdeemSDK()
		return sdk
	}()
	
	public var apiKey: String?
	public var baseUrl: URL?
	
	
	public class func shared() -> PopdeemSDK {
		return sharedSDK
	}
	
	public static func with(apiKey: String, baseUrlString: String) {
		let sdk = sharedSDK
		sdk.apiKey = apiKey
		sdk.baseUrl = URL(string: baseUrlString)
	}
	
	public static func with(apiKey: String) {
		let sdk = sharedSDK
		sdk.apiKey = apiKey
	}
	
	public static func presentHome(toNavigationController controller: UINavigationController) {
		PopdeemSDK.presentHome(toNavigationController: controller, animated: true)
	}
	
	public static func presentHome(toNavigationController controller: UINavigationController, animated: Bool) {
		let controller = PopdeemController(forNavigationController: controller)
		controller.push()
	}

}
