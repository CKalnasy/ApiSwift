import Foundation
import SwiftSerialize

public extension NSMutableURLRequest {
  convenience init(url: NSURL, className: String, functionName: String, params: [Any], additionalParams: [String: String]?) {
    self.init(URL: url)
    self.HTTPMethod = "POST"
    self.setValue("application/json", forHTTPHeaderField: "Accept")
    self.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let method = [
      "className": className,
      "functionName": functionName
    ]
    self.HTTPBody = self.encodeParams(params, additionalParams: additionalParams, method: method)
    self.setValue(String(self.HTTPBody?.length), forHTTPHeaderField: "Content-Length")
  }
  
  convenience init(url: NSURL, className: String, functionName: String, image: UIImage, additionalParams: [String: String]?) {
    self.init(URL: url)
    let method = [
      "className": className,
      "functionName": functionName
    ]
    setImage(image, params: method)
  }
}

extension NSMutableURLRequest {
  private func encodeParams(params: [Any], additionalParams: [String: String]?, method: [String: String]) -> NSData? {
    var ret:[String: Any] = [
      "args": params,
      "method": method,
    ]
    if let additionalParams = additionalParams {
      ret["params"] = additionalParams
    }
    return Serializer.serialize(ret)
  }

  private func setImage(image: UIImage, params: [String: AnyObject]?) {
    self.HTTPMethod = "POST"
    let boundary = _getBoundary()
    self.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    if let imageData = UIImageJPEGRepresentation(image, 1) {
      self.HTTPBody = _createBodyWithParameters(params, filePathKey: "file", imageDataKey: imageData, boundary: boundary)
    }
  }
  
  private func _createBodyWithParameters(parameters: [String: AnyObject]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
    let body = NSMutableData()
    if parameters != nil {
      for (key, value) in parameters! {
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
        body.appendString("\(value)\r\n")
      }
    }
    
    let filename = "image"
    let mimetype = "image/jpg"
    body.appendString("--\(boundary)\r\n")
    body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
    body.appendString("Content-Type: \(mimetype)\r\n\r\n")
    body.appendData(imageDataKey)
    body.appendString("\r\n")
    body.appendString("--\(boundary)--\r\n")
    return body
  }
  
  private func _getBoundary() -> String {
    return "Boundary-\(NSUUID().UUIDString)"
  }
}

extension NSMutableData {
  func appendString(string: String) {
    let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
    appendData(data!)
  }
}