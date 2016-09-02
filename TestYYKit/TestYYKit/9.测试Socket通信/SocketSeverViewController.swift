//
//  SocketSeverViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/18.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable force_cast
// swiftlint:disable colon
// swiftlint:disable control_statement
// swiftlint:disable valid_docs
// swiftlint:disable opening_brace
// swiftlint:disable trailing_newline
// swiftlint:disable trailing_semicolon
// swiftlint:disable variable_name
// swiftlint:disable legacy_constant
// swiftlint:disable legacy_constructor
// swiftlint:disable comma
// swiftlint:disable statememt_position
// swiftlint:disable trailing_whitespace

import UIKit
import CocoaAsyncSocket

class SocketSeverViewController: UIViewController {

    @IBOutlet weak var infoTV: UITextView!
    @IBOutlet weak var msgTF: UITextField!
    @IBOutlet weak var portTF: UITextField!
    var severSockect: GCDAsyncSocket?
    
    var clinetSocket: GCDAsyncSocket?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //对InfoTextView添加提示内容
    
    @IBAction func listeningAct(sender: AnyObject) {
        severSockect = GCDAsyncSocket(delegate: self, delegateQueue: dispatch_get_main_queue())
        do {
           try severSockect?.acceptOnPort(UInt16(portTF.text!)!)
              addText("监听成功")
        } catch {
            addText("监听失败")
        }
    
    }
    
    
    @IBAction func sendAct(sender: AnyObject) {
        let data = msgTF.text?.dataUsingEncoding(NSUTF8StringEncoding)
        clinetSocket?.writeData(data, withTimeout: -1, tag: 0)
    }
  
    func addText(text: String) {
        infoTV.text = infoTV.text.stringByAppendingFormat("%@\n", text)
    }
}

extension SocketSeverViewController: GCDAsyncSocketDelegate {
    func socket(sock: GCDAsyncSocket!, didAcceptNewSocket newSocket: GCDAsyncSocket!) {
        addText("连接成功")
        addText("连接地址" + newSocket.connectedHost)
        addText("端口号" + String(newSocket.connectedPort))
        clinetSocket = newSocket
        
        //第一次开始读取Data
        clinetSocket!.readDataWithTimeout(-1, tag: 0)
    }
    
    func socket(sock: GCDAsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        let message = String(data: data,encoding: NSUTF8StringEncoding)
        addText(message!)
        //再次准备读取Data,以此来循环读取Data
        sock.readDataWithTimeout(-1, tag: 0)
    }
}
