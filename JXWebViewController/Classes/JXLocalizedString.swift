//
//  JXLocalizedString.swift
//  JXWebViewController
//
//  Created by swordray on 01/17/2018.
//  Copyright (c) 2018 swordray. All rights reserved.
//

func JXLocalizedString(_ key: String) -> String {
    let path = Bundle(for: JXWebViewController.self).path(forResource: "JXWebViewController", ofType: "bundle")!
    let bundle = Bundle(path: path)!
    return NSLocalizedString(key, bundle: bundle, comment: "")
}
