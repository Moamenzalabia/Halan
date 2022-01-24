//
//  StartViewController.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: IBOutlets
    
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
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
