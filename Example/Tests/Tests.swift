import UIKit
import XCTest
import ApiSwift
import CoreLocation
import ApiSwiftModule
import SwiftSerialize

class ApiTests: XCTestCase {
  func testMethodCallWithParams() {
    let url = NSURL(string: "http://localhost:8000/src/Test/api_test_handler.php")
    let obj1 = TestClass(string: "String 1", number: 54, location: CLLocationCoordinate2DMake(39, 49), array: [1, 2, 3], map: ["key1" : ["key2": 43]], set: Set([1.4, 1, 3.6, 66.6]))
    let params:[Any] = [obj1]
    let additionalParams:[String: String] = [
      "key1": "value 1",
      "key2": "value 2"
    ]
    let request = NSMutableURLRequest(url: url!, className: "TestClass", functionName: "testFunctionParams", params: params, additionalParams: additionalParams)
    let expectation = expectationWithDescription("1")
    
    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
      if let data = data {
        let obj = try! Serializer.deserialize(data) as! TestClass
        XCTAssertEqual(obj1, obj)
      } else {
        XCTFail("No json object was returned from the server")
      }
      expectation.fulfill()
    }.resume()
    
    waitForExpectationsWithTimeout(5, handler: nil)
  }
  
  func testMethodCallWithImage() {
    let url = NSURL(string: "http://localhost:8000/src/Test/api_test_handler.php")
    let additionalParams:[String: String] = [
      "key1": "value 1",
      "key2": "value 2"
    ]
    let request = NSMutableURLRequest(url: url!, className: "TestClass", functionName: "testFunctionImage", image: UIImage(color: UIColor.redColor(), size: CGSize(width: 5, height: 5)), additionalParams: additionalParams)
    let expectation = expectationWithDescription("1")
    
    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
      let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
      XCTAssertEqual("1", str)
      expectation.fulfill()
    }.resume()
    
    waitForExpectationsWithTimeout(5, handler: nil)
  }
}

extension UIImage {
  convenience init(color: UIColor, size: CGSize) {
    let rect = CGRectMake(0, 0, size.width, size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.init(CGImage: image.CGImage!)
  }
}
