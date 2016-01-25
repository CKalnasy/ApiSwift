#
# Be sure to run `pod lib lint ApiSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ApiSwift"
  s.version          = "0.1.6"
  s.summary          = "A library to call a specified function on a server from Swift 2.0"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
Call a function on a server with parameters as swift objects.
Parameters are serialized, sent to the server, deserialized, then passed as arguments to the specific function 
                       DESC

  s.homepage         = "https://github.com/ckalnasy/ApiSwift"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "CKalnasy" => "kalnasy.6@osu.edu" }
  s.source           = { :git => "https://github.com/ckalnasy/ApiSwift.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'ApiSwift/*'
  s.resource_bundles = {
    'ApiSwift' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 
  s.dependency 'SwiftSerialize'
end
