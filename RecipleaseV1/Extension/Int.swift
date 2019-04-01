//
//  Int.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 28/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation

extension Int {
	var convertIntToTime: String {
		let h = self / 3600
		let m = (self % 3600) / 60
		let s = (self % 3600) % 60
		return h > 0 ? String(format: "%1d:%02d:%02d", h, m, s) : String(format: "%1d:%02d", m, s)
	}
}
