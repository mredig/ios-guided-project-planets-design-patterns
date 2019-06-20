//
//  PlanetDetailViewController.swift
//  Planets
//
//  Created by Andrew R Madsen on 9/20/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class PlanetDetailViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var label: UILabel!

	var planet: Planet? {
		didSet {
			updateViews()
		}
	}


    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }

	override func encodeRestorableState(with coder: NSCoder) {
		defer { super.encodeRestorableState(with: coder) }
		var planetData: Data?

		do {
			planetData = try PropertyListEncoder().encode(planet)
		} catch {
			NSLog("error encoding planet: \(error)")
		}

		coder.encode(planetData, forKey: "planetData")
	}

	override func decodeRestorableState(with coder: NSCoder) {
		defer { super.decodeRestorableState(with: coder) }

		guard let planetData = coder.decodeObject(forKey: "planetData") as? Data else { return }
		do {
			let planet = try PropertyListDecoder().decode(Planet.self, from: planetData)
			self.planet = planet
		} catch {
			NSLog("error decoding planet: \(error)")
		}
	}
    
    private func updateViews() {
        guard let planet = planet, isViewLoaded else {
            imageView?.image = nil
            label?.text = nil
            return
        }
        
        imageView.image = planet.image
        label.text = planet.name
    }

}
