//
//  ActivityViewController.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import UIKit

class ActivityViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    static func instance()-> ActivityViewController {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "ActivityViewController") as! ActivityViewController
        return vc
    }
    
    lazy var viewModel: ActivityViewModel = {
        return ActivityViewModel(service: ActivityDataService())
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        initViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Methods
    func configureUI() {
        linkLabel.underline()
        navigationItem.title = "Activity"
    }
    
    func initViewModel() {
        
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                if let message = self.viewModel.alertMessage {
                    self.showAlertError(message: message)
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                    case .empty, .error:
                        self.stopLoading()
                    case .loading:
                        self.startLoading()
                    case .populated:
                        self.stopLoading()
                }
            }
        }
        
        viewModel.updateUIClosure = { [weak self] () in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                self.updateUI(activity: self.viewModel.activityDataViewModel)
            }
        }
        viewModel.fetchActivity()
    }
    
    func updateUI(activity: ActivityDataViewModel?) {
        titleLabel.text = activity?.activity
        activityLabel.text = activity?.activity
        typeLabel.text = activity?.type
        participantsLabel.text = "\(activity?.participants ?? 0)"
        priceLabel.text = "\(activity?.price ?? 0)"
        linkLabel.text = activity?.link
    }
    
    func startLoading() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self = self else {
                return
            }
            self.activityIndicator.startAnimating()
            self.containerView.alpha = 0.0
        })
    }
    
    func stopLoading() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self = self else {
                return
            }
            self.activityIndicator.stopAnimating()
            self.containerView.alpha = 1.0
        })
    }
    
    func showAlertError(message: String) {
        self.showDefaultAlert(title: "Error", message: message, actionTitle: "OK") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - IBActions
    @IBAction func replaceActivityButtonDidPressed(_ sender: Any) {
        viewModel.fetchActivity()
    }
    
}
