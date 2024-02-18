//
//  HomeScreenController.swift
//  APIRouter
//
//  Created by Sharad Chauhan on 15/02/24.
//

import Foundation

//MARK:- API call class
struct APIRouter<T: Codable> {
    
    // MARK: - Local Variables
    private let session: URLSessionProtocol
    
    // MARK: - Init
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    // MARK: API Request
    func requestData(_ router: APIRoutable,
                     completion : @escaping (_ model : T?, _ statusCode: Int? , _ error : Error?) -> Void ) {
        
        let queue = DispatchQueue(label: "network-thread", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem, target: .none)
        queue.async {
            let task = self.session.dataTask(with: router.request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    curateResponseForUI(router, data, httpResponse.statusCode, error, completion: completion)
                } else {
                    curateResponseForUI(router, data, nil, error, completion: completion)
                }
            }
            task.resume()
        }
        
    }
    
    private func curateResponseForUI(_ router: APIRoutable, _ data: Data?, _ statusCode: Int?, _ error: Error?, completion : @escaping (_ model : T?, _ statusCode: Int? , _ error : Error?) -> Void) {
        guard error == nil, let code = statusCode, (200..<300) ~= code, let properData = data else {
            return completion(nil, statusCode, GenericAPIErrors.invalidAPIResponse)
        }
        do {
            let model = try JSONDecoder().decode(T.self, from: properData)
            completion(model, statusCode,  nil)
        } catch {
            completion(nil, statusCode, GenericAPIErrors.decodingError)
        }
    }
}
