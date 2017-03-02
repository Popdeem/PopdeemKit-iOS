//
//  ErrorView.swift
//  PopdeemKit
//
//  Created by Niall Quinn on 02/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ErrorView: UIView {
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var messageLabel: UILabel!
	@IBOutlet var retryButton: UIButton!
	
	var error: Error? {
		didSet {
			titleLabel.text = error?.title
			messageLabel.text = error?.message
		}
	}
}
