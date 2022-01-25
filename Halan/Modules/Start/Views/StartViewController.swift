//
//  StartViewController.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func startButtonDidPressed(_ sender: Any) {
        navigateToActivityViewController()
    }
    
    // MARK: - Navigation
    func navigateToActivityViewController() {
        let activityViewController = ActivityViewController.instance()
        navigationController?.pushViewController(activityViewController, animated: true)
    }
}
