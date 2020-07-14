# JXWebViewController

An iOS view controller wrapper for [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview).

[![CI Status](http://img.shields.io/travis/swordray/JXWebViewController.svg?style=flat)](https://travis-ci.org/swordray/JXWebViewController)
[![Version](https://img.shields.io/cocoapods/v/JXWebViewController.svg?style=flat)](http://cocoapods.org/pods/JXWebViewController)
[![License](https://img.shields.io/cocoapods/l/JXWebViewController.svg?style=flat)](http://cocoapods.org/pods/JXWebViewController)
[![Platform](https://img.shields.io/cocoapods/p/JXWebViewController.svg?style=flat)](http://cocoapods.org/pods/JXWebViewController)

Since iOS 8, WKWebView is preferred over UIWebView. But unlike UIWebView, WKWebView provide less default behaviors due to the security design. JXWebViewController wrap up a WKWebView and implements a few standard features as iOS Safari does. So web views can be easily used in your apps out-of-the-box. It is also referred to as WebViewController, UIWebViewController or WKWebViewController.

## Features

* Allows back forward navigation gestures.
* Support HTTP Basic access authentication.
* Implement JavaScript `alert`, `confirm` and `prompt`.
* Open native links of `mailto`, `tel`, `itms-apps` and so on.
* Open and close pages in current view.
* Reload when web content process is terminated.
* Perform auto detection of phone numbers.
* Proxy the page title to the controller title.
* Add the refresh control.
* Support Handoff from app to Safari.

## Requirements

* iOS 11.0+
* Xcode 9.0+
* Swift 4.0+

## Installation

JXWebViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JXWebViewController'
```

## Usage

### Quick Start

```swift
let url = URL(string: "https://example.com/")!

let webViewController = JXWebViewController()
webViewController.webView.load(URLRequest(url: url))
navigationController?.pushViewController(webViewController, animated: true)
```

### Customization

* Use `webView` property to access the [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview) instance.
* Use `webViewConfiguration` property to set up [WKWebViewConfiguration](https://developer.apple.com/documentation/webkit/wkwebviewconfiguration) before view is loaded.
* Create a `JXWebViewController` subclass which implements or overrides [WKNavigationDelegate](https://developer.apple.com/documentation/webkit/wknavigationdelegate) and [WKUIDelegate](https://developer.apple.com/documentation/webkit/wkuidelegate) methods.

## Credits

Jianqiu Xiao, swordray@gmail.com

## License

JXWebViewController is available under the MIT license. See the LICENSE file for more info.
