//
//  InfoSettingsTableViewController.swift
//  Inception
//
//  Created by David Ehlen on 24.10.15.
//  Copyright © 2015 David Ehlen. All rights reserved.
//

import UIKit
import MessageUI

class InfoSettingsTableViewController: UITableViewController,MFMailComposeViewControllerDelegate {
    @IBOutlet weak var versionLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            self.versionLabel.text = version
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 2 {
            let emailTitle = ""
            let messageBody = self.generateMailBody()
            let toRecipents = ["dehlen@me.com"]
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(emailTitle)
            mc.setMessageBody(messageBody, isHTML: false)
            mc.setToRecipients(toRecipents)
            
            self.presentViewController(mc, animated: true, completion: nil)
        }
    }

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    func generateMailBody() -> String {
        
        let device = UIDevice.currentDevice()
        let model = device.model
        let systemVersion = device.systemVersion
        let language = NSLocale.preferredLanguages()[0]
        let country = NSLocale.currentLocale().localeIdentifier
        let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String
        let languageLocalized = "language".localized
        let countryLocalized = "country".localized
        
        var returnString = "\n\n---\nModel: \(model)\nSystem Version: \(systemVersion)\n\(languageLocalized):\(language)\n\(countryLocalized): \(country)"
        if version != nil {
            returnString += "\nApp Version: \(version!)"
        }
        
        return returnString
    }
}
