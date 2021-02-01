//
//  QRGeneratorAPIClient.swift
//  QRGenerator
//
//  Created by Mangrulkar on 28/01/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import UIKit

class QRGeneratorAPIClient {
    
    typealias ResultCompletionHandler = (Data?, Error?) -> Void
    
    private let decoder = JSONDecoder()
    private let session: URLSession
    
    /// Create the base url for api call
    /// - Parameter requestData: request data object
    /// - Returns: returns the url
    private func baseUrl(_ requestData: CustomRequest) -> URL {
        
        let urlString = "https://api.qrserver.com/v1/create-qr-code/?size=\(requestData.size)&data=\(requestData.data)&color=\(requestData.color)&bgcolor=\(requestData.bgcolor)&margin=\(requestData.margin)&format=\(requestData.format)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return URL(string:urlString!)!
    }
    
    /// Configure initialization
    /// - Parameter configuration: URLSession object
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    /// Convenience initializer of class
    convenience init() {
        self.init(configuration: .default)
    }
    
    /// Generate request and API call
    /// - Parameters:
    ///   - requestData: Request object
    ///   - completion: Completion handler
    /// - Returns: Return response data
    private func getBaseRequest(at requestData: CustomRequest,
                                completionHandler completion:  @escaping (_ object: Data?,_ error: Error?) -> ()) {
        
        let url = baseUrl(requestData)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        DispatchQueue.main.async() {
                            completion(data, error)
                        }
                    } else {
                        completion(nil, error)
                    }
                } else if let error = error {
                    print("error \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    /// Generate the QR code
    /// - Parameters:
    ///   - requestData: Request object
    ///   - completion: Completion handler
    func getGeneratedCode(_ requestData: CustomRequest, completion: @escaping ResultCompletionHandler) {
        getBaseRequest(at: requestData) { (result, error) in
            completion(result, error)
        }
    }
    
}
