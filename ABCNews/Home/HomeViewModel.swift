//
//  HomeViewModel.swift
//  ABCNews
//
//  Created by Mac on 06/06/22.
//

import Foundation
import UIKit
import AVFoundation

class HomeViewModel: NSObject {
    
    var model: FeedViewModel?
    
    func callingHTTPAPI(completion: @escaping ((_ success: Bool) -> Void)) {
        
        NetworkManager.shared.callingHTTPApi { response, error in
            
            if let error = error {
                completion(false)
                return
            }
            
            guard let response = response else {
                completion(false)
                return
            }
            self.model = FeedViewModel(json: response)
            completion(true)
        }
        
    }
    
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch index {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BannerFeedTableViewCell.identifier, for: indexPath) as? BannerFeedTableViewCell {
                cell.item = model?.items[indexPath.row]
                cell.selectionStyle = .none
                cell.mainView.setCornerRadius(radii: 20)
                cell.mainView.clipsToBounds = true
                return cell
            }
            return UITableViewCell()
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RegularFeedTableViewCell.identifier, for: indexPath) as? RegularFeedTableViewCell {
                cell.item = model?.items[indexPath.row]
                cell.selectionStyle = .none
                cell.setCornerRadius(radii: 20)
                cell.mainView.setCornerRadius(radii: 20)
                cell.mainView.clipsToBounds = true
                return cell
            }
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        switch index {
        case 0:
            return 450
        default:
            return 180
        }
    }
    
    
    
    
}
