//
//  API_conf.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 22.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation


class API_conf {
    static func getGetRequst(url: String, params: [String: Any]?)-> URLRequest {
        
        var requestURL = url
        
        if params != nil {
            requestURL  = requestURL + "?"
            for (key, value) in params! {
                requestURL += "\(key)" + "=" + "\(value)" + "&"
            }
            requestURL = String(requestURL.dropLast())
        }
        
        let url1 = URL(string: requestURL)
        
        var request = URLRequest(url: url1!)
        
        request.httpMethod = "GET"
        return request
    }
    
    static func getPostRequest(url: String,body: Any) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let data = try! JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type" )
        request.httpBody = data as! Data
        return request
    }
    
    static func acceptDataFromServer(data: Data?, RequestError: Error?,success: (_ json: Any)-> Void, failure: (_ errorDescription: String)->Void) {
        
        if let error = RequestError {
            switch error._code {
            case NSURLErrorBadURL:
                failure("Плохое подключение")
            case NSURLErrorTimedOut:
                failure("Время вышло")
            case NSURLErrorNotConnectedToInternet:
                failure("Нет подключения к интернету")
            default: failure("что то пошло не так")
            }
        }
        
        guard let data = data else {
            failure("Не удалось полуить данные с сервера")
            return
        }
        print()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            success(json)
        } catch {
            failure("Serialize is fail")
        }
        
    }
}
