#
# Be sure to run `pod lib lint JXWebViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JXWebViewController'
  s.version          = '0.1.2'
  s.summary          = 'An iOS view controller wrapper for WKWebView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Since iOS 8, WKWebView is preferred over UIWebView. But unlike UIWebView, WKWebView provide less default behaviors due to the security design. JXWebViewController wrap up a WKWebView and implements a few standard features as iOS Safari does. So web views can be easily used in your apps out-of-the-box. It is also referred to as WebViewController, UIWebViewController or WKWebViewController.
                       DESC

  s.homepage         = 'https://github.com/swordray/JXWebViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jianqiu Xiao' => 'swordray@gmail.com' }
  s.source           = { :git => 'https://github.com/swordray/JXWebViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'JXWebViewController/Classes/**/*'

  s.resource_bundles = {
    'JXWebViewController' => ['JXWebViewController/*.lproj']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'WebKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
