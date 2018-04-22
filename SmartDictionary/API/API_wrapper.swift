//
//  API_wrapper.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 22.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import SwiftyJSON


class API_wrapper {
    //MARK: translate
    class func getTranslate(text: String, locale: String, success: @escaping (_ json: Any)->Void, failure: @escaping (_ errorDescription: String)-> Void)-> URLSessionTask {
        
        let encodeText = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let url = const.API_statements.translate_url
        let params: [String: Any] = [
            "key": const.API_statements.API_key,
            "text": encodeText ?? "",
            "lang": locale,
            "format": "plain",
        ]

        let request = API_conf.getGetRequst(url: url, params: params)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.acceptDataFromServer(data: data, RequestError: requestError, success: success, failure: failure)
        }

        dataTask.resume()
        return dataTask
    }
}

extension API_wrapper {
    class func getAllCardSet(success: @escaping (_ json: Any)-> Void, failure: @escaping (_ error: String)-> Void) -> URLSessionDataTask {
        let url = const.API_statements.base_url + "/api/cards"
        let params: [String: Any] = ["": ""]
        
        let request = API_conf.getGetRequst(url: url, params: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.acceptDataFromServer(data: data, RequestError: requestError, success: success, failure: failure)
        }
        
        dataTask.resume()
        return dataTask
    }
    
    class func getCardSet(id: Int, success: @escaping (_ json: Any)-> Void, failure: @escaping (_ error: String)-> Void )-> URLSessionDataTask {
        let url = const.API_statements.base_url + "/api/cards/\(id)"
        let params: [String: Any] = ["": ""]
        
        let request = API_conf.getGetRequst(url: url, params: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.acceptDataFromServer(data: data, RequestError: requestError, success: success, failure: failure)
        }
        
        dataTask.resume()
        return dataTask
    }
}
