//
//  SWEnterPasswordWindowController.swift
//  Switcher
//
//  Created by X140Yu on 6/9/16.
//  Copyright © 2016 X140Yu. All rights reserved.
//

import Cocoa

enum SWLoginType {
    case None
    case iBooks
    case AppStore
    case iTunes
}

class SWEnterPasswordWindowController: NSWindowController {

    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var prompotTextField: NSTextField!
    var userName = ""
    var loginType = SWLoginType.None

    override func windowDidLoad() {
        super.windowDidLoad()
        passwordTextField.stringValue = ""
        prompotTextField.stringValue = "Enter password for \(userName)"
    }

    @IBAction func SignIn(sender: NSButton) {
        let password = passwordTextField.stringValue
        if password != "" {
            SWAccountManager.sharedInstance.save(password, with: userName)
            window?.sheetParent?.endSheet(window!, returnCode: NSModalResponseOK)
            switch loginType {
            case .iBooks:
                SWAppLoginManager.loginiBooksWith(userName, password: password)
            case .AppStore:
                SWAppLoginManager.loginAppStoreWith(userName, password: password)
            case .iTunes:
                SWAppLoginManager.loginiTnesWith(userName, password: password)
            default: break
            }
        }
    }

    @IBAction func cancel(sender: NSButton) {
        window?.sheetParent?.endSheet(window!, returnCode: NSModalResponseCancel)
    }
}
