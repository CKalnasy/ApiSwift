import Foundation

public extension NSMutableURLRequest {
  convenience init(url: NSURL, className: String, functionName: String, params: Array<Any>, additionalParams: [String: String]?) {
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
}
