//
//  SocketClientViewController.swift
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

class SocketClientViewController: UIViewController {

    @IBOutlet weak var infoTf: UITextView!
    @IBOutlet weak var ipTf: UITextField!
    @IBOutlet weak var msgTf: UITextField!
    @IBOutlet weak var portTF: UITextField!
    var  socketSever: GCDAsyncSocket?
    
    func addText(text: String) {
        infoTf.text = infoTf.text.stringByAppendingFormat("%@\n", text)
    }

    @IBAction func connect(sender: AnyObject) {
        socketSever = GCDAsyncSocket(delegate: self, delegateQueue: dispatch_get_main_queue())
        do {
           try  socketSever?.connectToHost(ipTf.text, onPort: UInt16( (portTF?.text!)!)!)
            addText("连接成功")
        } catch {
            print(error)
        }
    }
    
    @IBAction func disconnect(sender: AnyObject) {
        socketSever?.disconnect()
        addText("断开连接")
    }
    
    @IBAction func send(sender: AnyObject) {
        socketSever?.writeData(msgTf.text?.dataUsingEncoding(NSUTF8StringEncoding) , withTimeout: -1, tag: 0)
    }
}

extension SocketClientViewController: GCDAsyncSocketDelegate {
    func socket(sock: GCDAsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        addText("连接服务器" + host)
        sock.readDataWithTimeout(-1, tag: 0)
    }
    
    func socket(sock: GCDAsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        let msg = String(data: data, encoding: NSUTF8StringEncoding)
        addText(msg!)
        sock.readDataWithTimeout(-1, tag: 0)
    }
}