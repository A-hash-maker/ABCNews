//
//  NetworkManager.swift
//  ABCNews
//
//  Created by Mac on 06/06/22.
//

import Foundation
import SwiftyJSON

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    
    func callingHTTPApi(completion: @escaping ((_ response: JSON?, _ error: Error?) -> Void)) {
        
        let baseURLString = AppConfiguration.BASEURL
        
        guard let url = URL(string: baseURLString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let returnData = JSON(json)
                completion(returnData, nil)
            }catch {
                completion(nil, error)
            }
        }.resume()
        
        
    }
    
    
    
    
}
