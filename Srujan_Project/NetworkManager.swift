//
//  NetworkManager.swift
//  Srujan_Project
//
//  Created by Srujan k on 04/03/20.
//  Copyright © 2020 Srujan k. All rights reserved.
//

import Foundation


public class NetworkManager {
    typealias CompletionHandler = (_ success: Bool, _ json: Any?, _ data: Data?) -> Void
    typealias FailureHandler = (_ statusCode: Int, _ error: Error?) -> Void

    static let sharedInstance = NetworkManager()
    private init(){}
    func getFacts(completion: @escaping CompletionHandler, failure: @escaping FailureHandler) {
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                failure(999, error)
                return
            }
            do {
                if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                    if statusCode == 200{
                        guard let unwrappedData = data else { return }
                        let utf8Data = String(decoding: unwrappedData, as: UTF8.self).data(using: .utf8)
                        let str = try JSONSerialization.jsonObject(with: utf8Data!, options: .allowFragments)
                        print(str)
                        completion(true, str, utf8Data)
                    }else{
                        failure(statusCode, error)
                    }
                }
            } catch {
                failure(999, error)
            }
        }
        task.resume()
    }
}
