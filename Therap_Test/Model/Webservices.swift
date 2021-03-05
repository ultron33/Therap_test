//
//  Webservices.swift
//  Therap_Test
//
//  Created by Iftiquar Ahmed Ove on 5/3/21.
//

import Foundation
import Alamofire

class Webservices {
    
    static let shared = Webservices()
    
    static var gitInfo: GitInfo?
    
    enum Endpoints {
        static let base = "https://api.github.com/search/repositories?q=language:Swift&sort=stars&order=desc"
        case getGitInfo
        var stringValue: String {
            switch self {
            case .getGitInfo:
                return Endpoints.base
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    //MARK: - Get dashboard summary
    func getGitInfo(success: @escaping (_ status: Int,_ response: GitInfo?) -> Void) {
        AF.request(Endpoints.getGitInfo.url, method: .get).responseDecodable(of: GitInfo.self ){(response) in
            switch response.result{
            case .success(let result):
                Webservices.gitInfo = result
                success(200, result )
            case .failure(let error):
                print("Failed with error -> \(error)")
                success(400, nil)
            }
        }
    }
}
