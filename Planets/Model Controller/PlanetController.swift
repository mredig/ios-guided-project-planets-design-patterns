//
//  PlanetController.swift
//  Planets
//
//  Created by Andrew R Madsen on 8/2/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

class PlanetController {

	var planets: [Planet] {
		let shouldShowPluto = UserDefaults.standard.bool(forKey: .shouldShowPlutoKey)
		var result = [
			Planet(name: "Mercury", imageName: "mercury"),
			Planet(name: "Venus", imageName: "venus"),
			Planet(name: "Earth", imageName: "earth"),
			Planet(name: "Mars", imageName: "mars"),
			Planet(name: "Jupiter", imageName: "jupiter"),
			Planet(name: "Saturn", imageName: "saturn"),
			Planet(name: "Uranus", imageName: "uranus"),
			Planet(name: "Neptune", imageName: "neptune"),
			Planet(name: "Pluto", imageName: "pluto"),
		]

		if shouldShowPluto {
			return result
		} else {
			_ = result.popLast()
			return result
		}

	}
}
