//
//  ViewController.swift
//  ABCNews
//
//  Created by Mac on 06/06/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var refreshingLbl: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
    }
    
    private func setupTableView() {
        feedTableView.delegate = viewModel
        feedTableView.dataSource = viewModel
        feedTableView.register(BannerFeedTableViewCell.nib, forCellReuseIdentifier: BannerFeedTableViewCell.identifier)
        feedTableView.register(RegularFeedTableViewCell.nib, forCellReuseIdentifier: RegularFeedTableViewCell.identifier)
        feedTableView.refreshControl = UIRefreshControl()
        feedTableView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
    }
    
    private func setupView() {
        let label = UILabel()
        label.textColor = AppColor.FERNGREEN
        label.text = "GeeksForGeeks"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        callingAPI()
    }
    
    
    
    private func callingAPI() {
        spinner.startAnimating()
        viewModel.callingHTTPAPI { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.feedTableView.refreshControl?.endRefreshing()
                    self?.feedTableView.reloadData()
                    
                }
            }
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                self?.refreshingLbl.isHidden = true
            }
        }
    }
    
    @objc func callPullToRefresh() {
        self.refreshingLbl.text = "Refreshing..."
        self.refreshingLbl.isHidden = false
        self.callingAPI()
    }
    


}

