//
//  UploadVC.swift
//  uploadIPA
//
//  Created by Jason on 2018/11/1.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

class UploadVC: NSViewController {

    @IBOutlet weak var parsingView: NSView!
    
    @IBOutlet weak var infoView: NSView!
    
    @IBOutlet weak var appNameLabel: NSTextField!
    
    @IBOutlet weak var appIconImageView: NSImageView!
    
    @IBOutlet weak var parsingIndicator: NSProgressIndicator!
    
    @IBOutlet weak var uploadingProgressIndicator: NSProgressIndicator!
    
    @IBOutlet weak var cancelButton: NSButton!
    
    @IBOutlet weak var resultStatusView: NSView!
    
    @IBOutlet weak var resultStatusLabel: NSTextFieldCell!
    
    @IBOutlet weak var resultStatusImageView: NSImageView!
    
    var cancelActionCallback: (()->Void)?
    
    var appInfo: ParsedAppModel? {
        didSet{
            appNameLabel.stringValue = ""
            
            if let appName = appInfo?.name {
                appNameLabel.stringValue = appNameLabel.stringValue + appName
            }
            if let version = appInfo?.version {
                appNameLabel.stringValue = appNameLabel.stringValue + " \(version)"
            }
            if let build = appInfo?.build {
                appNameLabel.stringValue = appNameLabel.stringValue + " Build(\(build))"
            }
            
            appIconImageView.image = appInfo?.icon
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startParsing() {
        infoView.isHidden = true
        parsingView.isHidden = false
        parsingIndicator.startAnimation(self)
    }
    
    func stopParsing() {
        parsingIndicator.stopAnimation(self)
        self.parsingView.isHidden = true
    }
    
    func startUpload() {
        parsingView.isHidden = true
        infoView.isHidden = false
    }
    
    func stopUpload() {
        parsingView.isHidden = true
        infoView.isHidden = true
    }
    
    func showResultStatus(success: Bool, message: String? = nil) {
        self.resultStatusView.isHidden = false
        self.resultStatusImageView.image = NSImage(named: (success ? "success" : "error"))
        
        if let message = message {
            self.resultStatusLabel.stringValue = message;
        }else{
            self.resultStatusLabel.stringValue = (success ? "上传成功！" : "上传失败！")
        }
        
        cancelButton.title = success ? "完成" :  "取消";
    }
    
    @IBAction func cancelAction(_ sender: NSButton) {
        cancelActionCallback?()
        self.dismiss(nil)
    }
}
