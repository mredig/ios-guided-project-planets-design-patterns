//
//  PlanetsCollectionViewController.swift
//  Planets
//
//  Created by Andrew R Madsen on 8/2/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class PlanetsCollectionViewController: UICollectionViewController, UIPopoverPresentationControllerDelegate {

	// MARK: - Properties

	let planetController = PlanetController()

	var plutoObserver: NSObjectProtocol?

    @IBAction func unwindToPlanetsCollectionViewController(_ sender: UIStoryboardSegue) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

	override func viewDidLoad() {
		super.viewDidLoad()
		observeShouldShowPluto()
	}

	func observeShouldShowPluto() {
		plutoObserver = NotificationCenter.default.addObserver(forName: .plutoSettingUpdated, object: nil, queue: nil) { (notification) in
			self.collectionView?.reloadData()
		}
	}
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planetController.planets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetCell", for: indexPath) as! PlanetCollectionViewCell
        
        let planet = planetController.planets[indexPath.item]
        cell.imageView.image = planet.image
        cell.textLabel.text = planet.name
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    // MARK: - UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSettings" {
            let detailVC = segue.destination
            let ppc = detailVC.popoverPresentationController
            if let button = sender as? UIButton {
                ppc?.sourceView = button
                ppc?.sourceRect = button.bounds
                ppc?.backgroundColor = .black
            }
            ppc?.delegate = self
        }
        
        if segue.identifier == "ShowPlanetDetail" {
            guard let indexPath = collectionView?.indexPathsForSelectedItems?.first else { return }
            let detailVC = segue.destination as! PlanetDetailViewController
            detailVC.planet = planetController.planets[indexPath.row]
        }
    }
}
