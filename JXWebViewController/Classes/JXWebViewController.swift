//
//  JXWebViewController.swift
//  JXWebViewController
//
//  Created by swordray on 01/17/2018.
//  Copyright (c) 2018 swordray. All rights reserved.
//

import WebKit

open class JXWebViewController: UIViewController {

    open var configuration = WKWebViewConfiguration()

    open var webView: WKWebView {
        loadViewIfNeeded()
        return view as! WKWebView
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        configuration.dataDetectorTypes = .phoneNumber
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func loadView() {
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.scrollView.refreshControl = UIRefreshControl()
        webView.scrollView.refreshControl?.addTarget(webView, action: #selector(webView.reload), for: .valueChanged)
        webView.uiDelegate = self
        view = webView
    }

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as? WKWebView == webView && keyPath == "title" {
            title = change?[.newKey] as? String
        }
    }
}

extension JXWebViewController: WKNavigationDelegate {

    open func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        switch challenge.protectionSpace.authenticationMethod {
        case NSURLAuthenticationMethodHTTPBasic:
            let title = String.localizedStringWithFormat(JXLocalizedString("Log in to"), challenge.protectionSpace.host)
            let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = JXLocalizedString("User Name")
                textField.text = challenge.proposedCredential?.user
            }
            alertController.addTextField { textField in
                textField.isSecureTextEntry = true
                textField.placeholder = JXLocalizedString("Password")
                textField.text = challenge.proposedCredential?.password
            }
            alertController.addAction(UIAlertAction(title: JXLocalizedString("Cancel"), style: .cancel) { _ in
                completionHandler(.cancelAuthenticationChallenge, nil)
            })
            alertController.addAction(UIAlertAction(title: JXLocalizedString("Log In"), style: .default) { _ in
                let user = alertController.textFields?.first?.text ?? ""
                let password = alertController.textFields?.last?.text ?? ""
                let credential = URLCredential(user: user, password: password, persistence: .forSession)
                completionHandler(.useCredential, credential)
            })
            alertController.preferredAction = alertController.actions.last
            present(alertController, animated: true)
        default:
            completionHandler(.performDefaultHandling, nil)
        }
    }

    open func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webView.scrollView.refreshControl?.endRefreshing()
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webView.scrollView.refreshControl?.endRefreshing()
    }

    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.scrollView.refreshControl?.endRefreshing()
    }

    open func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }

    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            if !WKWebView.handlesURLScheme(url.scheme ?? "") && UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        decisionHandler(.allow)
    }
}

extension JXWebViewController: WKUIDelegate {

    open func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if !(navigationAction.targetFrame?.isMainFrame ?? false) {
            webView.load(navigationAction.request)
        }
        return nil
    }

    open func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: JXLocalizedString("Close"), style: .default) { _ in
            completionHandler()
        })
        present(alertController, animated: true)
    }

    open func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: JXLocalizedString("Cancel"), style: .cancel) { _ in
            completionHandler(false)
        })
        alertController.addAction(UIAlertAction(title: JXLocalizedString("OK"), style: .default) { _ in
            completionHandler(true)
        })
        alertController.preferredAction = alertController.actions.last
        present(alertController, animated: true)
    }

    open func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: prompt, message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = defaultText
        }
        alertController.addAction(UIAlertAction(title: JXLocalizedString("Cancel"), style: .cancel) { _ in
            completionHandler(nil)
        })
        alertController.addAction(UIAlertAction(title: JXLocalizedString("OK"), style: .default) { _ in
            completionHandler(alertController.textFields?.first?.text)
        })
        alertController.preferredAction = alertController.actions.last
        present(alertController, animated: true)
    }

    open func webViewDidClose(_ webView: WKWebView) {
        webView.load(URLRequest(url: URL(string:"about:blank")!))
    }

    open func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        guard let scheme = elementInfo.linkURL?.scheme else { return false }
        return WKWebView.handlesURLScheme(scheme)
    }

    open func webView(_ webView: WKWebView, previewingViewControllerForElement elementInfo: WKPreviewElementInfo, defaultActions previewActions: [WKPreviewActionItem]) -> UIViewController? {
        guard let url = elementInfo.linkURL else { return nil }
        let webViewController = JXWebViewController()
        webViewController.configuration = configuration
        webViewController.webView.load(URLRequest(url: url))
        return webViewController
    }

    open func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
        let webViewController = previewingViewController as? JXWebViewController
        guard let url = webViewController?.webView.url else { return }
        webView.load(URLRequest(url: url))
    }
}
