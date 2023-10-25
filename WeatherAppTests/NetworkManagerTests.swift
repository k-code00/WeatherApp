//
//  NetworkManagerTests.swift
//  WeatherAppTests
//
//  Created by Kojo on 25/10/2023.
//

import XCTest
@testable import WeatherApp

class NetworkManagerTests: XCTestCase {

    // A mock URL for testing purposes.
    let mockURL = URL(string: "https://mockapi.io")!
    
    // Mock data representing successful response from the server.
    let mockSuccessfulData = """
    {
        "id": 1,
        "name": "Sample Name"
    }
    """.data(using: .utf8)!

    // Mock data representing malformed or unexpected response from the server.
    let mockFailedDecodingData = """
    {
        "id": "wrongType",
        "name": 12345
    }
    """.data(using: .utf8)!

    // Mock data representing invalid JSON.
    let invalidData = "This is not valid JSON".data(using: .utf8)!

    func testSuccessfulNetworkCallAndDecoding() {
        let expectation = self.expectation(description: "Fetch and decode data successfully")

        // Here, ideally, you'd use a network stubbing library to ensure that the fetch function uses `mockSuccessfulData` for the given `mockURL`.
        
        NetworkManager<MockDecodableModel>.fetch(for: mockURL) { result in
            switch result {
            case .success(let model):
                XCTAssertNotNil(model)
                XCTAssertEqual(model.id, 1)
                XCTAssertEqual(model.name, "Sample Name")
            case .failure(let error):
                XCTFail("Expected successful decoding, but got error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testFailedDecoding() {
        let expectation = self.expectation(description: "Expecting a decoding error")
        
        NetworkManager<MockDecodableModel>.fetch(for: mockURL) { result in
            switch result {
            case .success:
                XCTFail("Expected decoding error but got a successful response.")
            case .failure(let error):
                XCTAssertEqual(error, .decodingError(err: "Decoding failed due to...")) 
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }


    func testNetworkError() {
        let expectation = self.expectation(description: "Expecting a network error")
        
        let invalidURL = URL(string: "https://invalid.url")!
        
        NetworkManager<MockDecodableModel>.fetch(for: invalidURL) { result in
            switch result {
            case .success:
                XCTFail("Expected network error but got a successful response.")
            case .failure(let error):
                XCTAssertEqual(error, .error(err: "network error message"))
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }


    func testNon200HTTPStatusCode() {
        let expectation = self.expectation(description: "Expecting an invalid response due to non-200 status code")
        
        NetworkManager<MockDecodableModel>.fetch(for: mockURL) { result in
            switch result {
            case .success:
                XCTFail("Expected invalid response but got a successful response.")
            case .failure(let error):
                XCTAssertEqual(error, .invalidResponse)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }


    func testInvalidData() {
        let expectation = self.expectation(description: "Expecting invalid data error")
        
        NetworkManager<MockDecodableModel>.fetch(for: mockURL) { result in
            switch result {
            case .success:
                XCTFail("Expected invalid data error but got a successful response.")
            case .failure(let error):
                XCTAssertEqual(error, .invalidData)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

}

// A mock model that conforms to Decodable for testing purposes.
struct MockDecodableModel: Decodable {
    let id: Int
    let name: String
}
