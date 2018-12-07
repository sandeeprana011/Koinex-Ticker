//
//  ViewController.swift
//  Koinex Assignment
//
//  Created by Sandeep Rana on 07/12/18.
//  Copyright © 2018 Sandeep Rana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        KoinexNetworking.getTicker();
    }

}

class KoinexNetworking {
    class API {
        static let baseUrl = "https://koinex.in/api/";

        public enum Endpoints {
            case ticker(parameter: [String: Any]?)
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


            static func task(_ endpoint: API.Endpoints, method: Endpoints.Methods = .GET) -> URLSessionDataTask? {
                guard let url = URL(string: endpoint.path) else {
                    return nil;
                }
                var request = URLRequest(url: url)
                request.httpMethod = method.rawValue

                let sessionConfiguration = URLSessionConfiguration.default

                let session = URLSession(configuration: sessionConfiguration)

                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let dataResponse = data,
                          error == nil else {
                        print(error?.localizedDescription ?? "Response Error")
                        return
                    }
                    do {
                        //here dataResponse received from a network request
                        let jsonResponse = try JSONSerialization.jsonObject(with:
                        dataResponse, options: [])
                        print(jsonResponse) //Response result
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                }
                task.resume()
            }
        }

        class func getTicker() {
            guard let url = URL(string: API.ticker) else {
                return
            }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let dataResponse = data,
                      error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
                }
                do {
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                    print(jsonResponse) //Response result
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
        }
    }
