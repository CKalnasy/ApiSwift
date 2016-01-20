# ApiSwift

[![CI Status](http://img.shields.io/travis/CKalnasy/ApiSwift.svg?style=flat)](https://travis-ci.org/CKalnasy/ApiSwift)
[![Version](https://img.shields.io/cocoapods/v/ApiSwift.svg?style=flat)](http://cocoapods.org/pods/ApiSwift)
[![License](https://img.shields.io/cocoapods/l/ApiSwift.svg?style=flat)](http://cocoapods.org/pods/ApiSwift)
[![Platform](https://img.shields.io/cocoapods/p/ApiSwift.svg?style=flat)](http://cocoapods.org/pods/ApiSwift)

## Usage

```swift
import CoreLocation
import ApiSwift
import SwiftSerialize

let url = NSURL(string: "http://localhost:8000/Api.php")
let obj1 = TestClass(string: "Test str", number: 4.5, location: CLLocationCoordinate2D(latitude: 33.2, longitude: 44), array: [3, 5, 84, 23], map: ["key1": ["key2" : 82]], set: [3.3, 55.3, 32.1])
let obj2 = 4321
let params:[Any] = [obj1, obj2]
let additionalParams:[String: String] = [
  "id": "1234567890",
]

let request = NSMutableURLRequest(url: url!, className: "MyClass", functionName: "MyFunc", params: params, additionalParams: additionalParams)
NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
  // handle response
  let object = Serializer.deserialize(data!)
}.resume()
```

This example calls the MyFunc static function on the MyClass class. The 2 parameters are of type TestClass and an integer.
Traditional HTTP parameters can also be added to the request in the additionalParams.

## How it works

The objects passed as params are serialzed into JSON before being sent to the server. The server will deserialze the objects and recreate the
objects on the server. Then, the static class function specified is called with the deserialzed objects.

## Limitations

Currently the only server-side language that can handle this requust is PHP (https://github.com/ckalnasy/Api-php).

See github.com/ckalnasy/SwiftSerialize for other limitations as to what can be serialized/deserialized

## Running the Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

You'll also need to uncomment the commented lines in SwiftSerialize/Initializer.swift (in the SwiftSerialize pod) to run the test cases.

## Installation

ApiSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ApiSwift"
```

## Contributing

Will accept all valid pull requests, feature requests, and other issues. Want to help, just ask!

## License

ApiSwift is available under the MIT license. See the LICENSE file for more info.
