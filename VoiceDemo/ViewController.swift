//
//  ViewController.swift
//  VoiceDemo
//
//  Created by green on 16/4/25.
//  Copyright © 2016年 com.jietusoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BDRecognizerViewDelegate {
    
    var recognizerVC : BDRecognizerViewController!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recognizerVC = BDRecognizerViewController(origin: CGPointMake(9, 128), withTheme: BDTheme.defaultTheme())
        
        recognizerVC.delegate = self
        recognizerVC.enableFullScreenMode = true
        
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Action
    
    @IBAction private func say(sender: UIButton?) {
        
        let paramsObj = BDRecognizerViewParamsObject()

        paramsObj.apiKey = "T5edsUqq329gyFNVjtdM2SNZ"
        paramsObj.secretKey = "1a6e2e9771109e07fd138ca3fb3197c6"
        paramsObj.isNeedNLU = false
        paramsObj.language = BDVoiceRecognitionLanguageChinese
        paramsObj.recogPropList = [20000]
        paramsObj.cityID = 1
        paramsObj.resultShowMode = BDRecognizerResultShowModeContinuousShow
        paramsObj.recordPlayTones = EBDRecognizerPlayTonesRecordPlay
        paramsObj.isShowTipAfterSilence = false;
        paramsObj.isShowHelpButtonWhenSilence = false;
        paramsObj.tipsTitle = "可以使用如下指令记账";
        paramsObj.tipsList = ["我要记账", "买苹果花了十块钱", "买牛奶五块钱", "第四行滚动后可见", "第五行是最后一行"]
        
        recognizerVC.startWithParams(paramsObj)
    }
    
    // MARK: - BDRecognizerViewDelegate
    
    func onEndWithViews(aBDRecognizerViewController: BDRecognizerViewController!, withResults aResults: [AnyObject]!) {
        
        for tarray in aResults {
            
            if let temp = tarray as? NSArray {
                
                let result = temp.JSONString()
                print(result)
            }
        }
    }
    
    // MARK: - 
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func remoteControlReceivedWithEvent(event: UIEvent?) {
        
        guard let event = event else {
            
            return
        }
        
        if event.type == UIEventType.RemoteControl {
            
            switch event.subtype {
            case .None:
                break
                
            case .MotionShake:
                break
                
            case .RemoteControlPlay:
                print("play")
                break
                
            case .RemoteControlPause:
                print("pause")
                break
                
            case .RemoteControlStop:
                print("stop")
                break
                
            case .RemoteControlTogglePlayPause:
                print("单击暂停")
                
                self.say(nil)
                break
                
            case .RemoteControlNextTrack:
                print("双击暂停")
                recognizerVC.cancel()
                break
                
            case .RemoteControlPreviousTrack:
                print("三击暂停")
                break
                
            case .RemoteControlBeginSeekingBackward:
                break
                
            case .RemoteControlEndSeekingBackward:
                break
                
            case .RemoteControlBeginSeekingForward:
                break
                
            case .RemoteControlEndSeekingForward:
                break
                    
            }
        }
    }
}

