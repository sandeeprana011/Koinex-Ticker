//
//  KoinexNetworking.swift
//  Koinex Ticker
//
//  Created by Sandeep Rana on 07/12/18.
//  Copyright © 2018 Sandeep Rana. All rights reserved.
//

import UIKit

class KoinexNetworking {
    static func ticker(method: API.Endpoints.Methods = .GET, completionHandle: @escaping (Any) -> Void, errorHandler: @escaping (Error?) -> Void) -> URLSessionDataTask? {
        return API.startTask(.ticker, method: method, completionHandle: { data in

            do {
                // Lets decode data into an object
                let response = try JSONSerialization.jsonObject(with: data);
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(TickerResponse.self, from: data) //Usefull in case of similar response model
                completionHandle(response);
            } catch {
                if error._code == NSURLErrorCancelled {
                    print("Task Cancelled: " + error.localizedDescription)
                    return;
                } else {
//                    Handle other errors here like task canceled and others
                    print(error)
                }
            }
        }, errorHandler: errorHandler);
    }
}

class API {
    static let baseUrl = "https://koinex.in/api/";

    public enum Endpoints {
        case ticker, otherApi
        public var path: String {
            switch self {
            case .ticker:
                return "\(API.baseUrl)ticker"
            default:
                return "";
            }
        }

        public enum Methods: String {
            case POST, GET
        }

    }

    static func startTask(_ forEndpoint: API.Endpoints, method: Endpoints.Methods = .GET, completionHandle: @escaping (Data) -> Void, errorHandler: @escaping (Error?) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: forEndpoint.path) else {
            return nil;
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data,
                  error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                errorHandler(error);
                return
            }
            completionHandle(dataResponse);
        }
        task.resume()
        return task;
    }
}

