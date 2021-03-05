//
//  Webservices.swift
//  Therap_Test
//
//  Created by Iftiquar Ahmed Ove on 5/3/21.
//

import Foundation
import Alamofire

class DashboardWebService {
    
    static let shared = DashboardWebService()
    
    static let apiKey = "ZB43UN5agpmsh889A2qX4sOnrCwmp1mAjjpjsnkpVZmvtN15tl"
        
    static var summaryInfo: DashboardSummary?
    
    enum Endpoints {
        static let base = "https://cloud-pos.azurewebsites.net/api"
        case getSummary
        var stringValue: String {
            switch self {
            case .getSummary:
                return Endpoints.base + "/web/get-summary"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    //MARK: - Get dashboard summary
    func getDashboardSummary(locationId: String, success: @escaping (_ status: Int,_ response: DashboardSummary?) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token ?? "")"]
        let params : Parameters = ["id_sucursal_bodega_ubicacion": locationId]
        AF.request(Endpoints.getSummary.url, method: .post, parameters: params, headers: headers).responseDecodable(of: DashboardSummary.self ){(response) in
            switch response.result{
            case .success(let result):
                if result.success == true{
                    DashboardWebService.summaryInfo = result
                }
                success(200, result )
            case .failure(let error):
                print("Failed with error -> \(error)")
                success(400, nil)
            }
        }
    }
}
