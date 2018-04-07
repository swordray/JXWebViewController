//
//  JXLocalizedString.swift
//  JXWebViewController
//
//  Created by swordray on 01/17/2018.
//  Copyright (c) 2018 swordray. All rights reserved.
//

func JXLocalizedString(_ key: String) -> String {
    guard let path = Bundle(for: JXWebViewController.self).path(forResource: "JXWebViewController", ofType: "bundle") else { return "" }
    guard let bundle = Bundle(path: path) else { return "" }
    return NSLocalizedString(key, bundle: bundle, comment: "")
}
