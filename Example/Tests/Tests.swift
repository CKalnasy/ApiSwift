import UIKit
import XCTest
import ApiSwift
import CoreLocation
import ApiSwiftTestModule

class ApiTests: XCTestCase {
  func testMethodCall() {
    let url = NSURL(string: "http://localhost:8000/Api.php")
    let obj1 = TestClass(string: "String 1", number: 54, location: CLLocationCoordinate2DMake(39, 49), array: [1, 2, 3], map: ["key1" : ["key2": 43]], set: Set([1.4, 1, 3.6, 66.6]))
    let params:[Any] = [obj1]
    let additionalParams:[String: String] = [
      "key1": "value 1",
      "key2": "value 2"
    ]
    let request = NSMutableURLRequest(url: url!, className: "TestClass", functionName: "testFunction", params: params, additionalParams: additionalParams)
    let expectation = expectationWithDescription("1")
    
    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
      if let data = data {
        let expectedJson = String(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)
        let json = String(data: data, encoding: NSUTF8StringEncoding)
        
        XCTAssertEqual(expectedJson, json)
      } else {
        XCTFail("No json object was returned from the server")
      }
      expectation.fulfill()
    }.resume()
    
    waitForExpectationsWithTimeout(5, handler: nil)
  }
}
