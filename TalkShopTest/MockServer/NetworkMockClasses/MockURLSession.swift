//
//  MockURLSession.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 17/02/24.
//


import Foundation

class MockURLSession: URLSessionProtocol {
    
    //MARK: - Public variables
    var testDataJSONFile: String?
    var testError: Error?
    var testMethod: String?
    
    //MARK: - Private variables
    private var testDataTask = MockURLSessionDataTask()
    private var testData: Data?
    private (set) var lastURL: URL?
    
    private var defaultTestBundle: Bundle? {
        return Bundle.allBundles.first { $0.bundlePath.hasSuffix(".xctest") }
    }
    
    //MARK: - Private methods
    private func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    private func failureHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    //MARK: - Public methods
    func dataTask(with request: URLRequest, completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        testMethod = request.httpMethod
        do {
            guard let path = Bundle.main.path(forResource: testDataJSONFile, ofType: "json") else {
                testError = GenericAPIErrors.invalidAPIResponse
                completionHandler(testData, failureHttpURLResponse(request: request), testError)
                return testDataTask
            }
            testData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        } catch {
            
        }
        
        #warning("Added 1 sec delay for mocking")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completionHandler(self.testData, self.successHttpURLResponse(request: request), self.testError)
        }
        
        return testDataTask
    }
    
    
}

//MARK:- MockURLSessionDataTask
class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
