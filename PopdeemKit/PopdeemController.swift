//
//  PopdeemController.swift
//  PopdeemKit
//
//  Created by Niall Quinn on 02/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import Turbolinks

public class PopdeemController: NSObject {
	
	let baseUrl: URL
	fileprivate let webViewProcessPool = WKProcessPool()
	
	fileprivate lazy var webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
		configuration.userContentController.add(self, name: "turbolinksDemo")
		configuration.processPool = self.webViewProcessPool
		if #available(iOS 9.0, *) {
			configuration.applicationNameForUserAgent = "TurbolinksDemo"
		}
		return configuration
	}()
	
	fileprivate lazy var session: Session = {
		let session = Session(webViewConfiguration: self.webViewConfiguration)
		session.delegate = self
		return session
	}()
	
	let apiKey: String
	let navigationController: UINavigationController
	
	fileprivate var application: UIApplication {
		return UIApplication.shared
	}
	
	public init(forNavigationController navController: UINavigationController) {
		baseUrl = PopdeemSDK.shared().baseUrl!
		apiKey = PopdeemSDK.shared().apiKey!
		navigationController = navController
	}
	
	public func push() {
		presentVisitableForSession(session, url: baseUrl)
	}
	
	fileprivate func presentVisitableForSession(_ session: Session, url: URL, action: Action = .Advance) {
		let visitable = DemoViewController(url: url)
		
		if action == .Advance {
			navigationController.pushViewController(visitable, animated: true)
		} else if action == .Replace {
			navigationController.popViewController(animated: false)
			navigationController.pushViewController(visitable, animated: false)
		}
		
		session.visit(visitable)
	}
	
	fileprivate func presentNumbersViewController() {
		let viewController = UIViewController()
		navigationController.pushViewController(viewController, animated: true)
	}
	
	fileprivate func presentAuthenticationController() {
		let authenticationController = UIViewController()
		let authNavigationController = UINavigationController(rootViewController: authenticationController)
		navigationController.present(authNavigationController, animated: true, completion: nil)
	}
	
}

extension PopdeemController: SessionDelegate {
	public func session(_ session: Session, didProposeVisitToURL URL: Foundation.URL, withAction action: Action) {
		//Add custom paths here - or native takeovers
		presentVisitableForSession(session, url: URL, action: action)
	}
	
	public func session(_ session: Session, didFailRequestForVisitable visitable: Visitable, withError error: NSError) {
		NSLog("ERROR: %@", error)
		guard let demoViewController = visitable as? DemoViewController, let errorCode = ErrorCode(rawValue: error.code) else { return }
		
		switch errorCode {
		case .httpFailure:
			let statusCode = error.userInfo["statusCode"] as! Int
			switch statusCode {
			case 401:
				presentAuthenticationController()
			case 404:
				demoViewController.presentError(.HTTPNotFoundError)
			default:
				demoViewController.presentError(Error(HTTPStatusCode: statusCode))
			}
		case .networkFailure:
			demoViewController.presentError(.NetworkError)
		}
	}
	
	public func sessionDidStartRequest(_ session: Session) {
		application.isNetworkActivityIndicatorVisible = true
	}
	
	public func sessionDidFinishRequest(_ session: Session) {
		application.isNetworkActivityIndicatorVisible = false
	}
}

extension PopdeemController: WKScriptMessageHandler {
	public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
		if let message = message.body as? String {
			let alertController = UIAlertController(title: "Turbolinks", message: message, preferredStyle: .alert)
			alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			navigationController.present(alertController, animated: true, completion: nil)
		}
	}
}
