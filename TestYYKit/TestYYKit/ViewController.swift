//
//  ViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/7/25.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import YYKit
import SnapKit
import SVProgressHUD
import WebKit

let MessageHandler = "didGetPosts"

class ViewController: UIViewController ,UITextFieldDelegate,WKNavigationDelegate,WKScriptMessageHandler{

    @IBOutlet weak var rewind: UIBarButtonItem!
    
    @IBOutlet weak var forwardItem: UIBarButtonItem!
    
    @IBOutlet weak var refreashItem: UIBarButtonItem!
    var  posts:[Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        // 2.测试webKit
        setupWebView()
    }
    
    
    @IBAction func back(sender: AnyObject)
    {
        webView.goBack()
    }
    
    

    @IBAction func forward(sender: AnyObject)
    {
        webView.goForward()
    }
    
    @IBAction func refreash(sender: AnyObject)
    {
        webView.loadRequest(NSURLRequest(URL: webView.URL!))
    }
          //1.测试富文本
   
       private func setupLabel()
        {
            let text = NSMutableAttributedString()
            let one = NSMutableAttributedString(string: "shsdfdfdfdfadow")
            one.font = UIFont.boldSystemFontOfSize(17)
            one.color = UIColor.blackColor()
            let shadow = YYTextShadow()
             shadow.color = UIColor.init(white: 0.000, alpha: 0.490)
             shadow.offset = CGSizeMake(0, 1)
             shadow.radius = 5
            one.textShadow = shadow
            text.appendAttributedString(one)
            view.addSubview(label)
            let two = NSMutableAttributedString(string: "https://www.baidu.com")
            two.font = UIFont.systemFontOfSize(17)
            two.underlineStyle = NSUnderlineStyle.StyleSingle
            
            two.setTextHighlightRange(two.rangeOfAll(), color: UIColor.blueColor(), backgroundColor: UIColor.blackColor()) { (_, string, _, _) in
                SVProgressHUD.showInfoWithStatus(two.string)
            }
     
            
            text.appendAttributedString(two)
            label.attributedText = text
            
            label.textAlignment = NSTextAlignment.Center
            label.textVerticalAlignment = YYTextVerticalAlignment.Center
            label.snp_makeConstraints { (make) in
                make.center.equalTo(view.snp_center)
                make.width.equalTo(view.snp_width)
                make.height.equalTo(view.snp_height)
            }
            


       }
    
        private func setupWebView()
        {
            
           view.addSubview(webView)
            webView.snp_makeConstraints { (make) in
                make.top.equalTo(0)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(-44)
            }
         
            
          navigationController!.navigationBar.addSubview(textField)
            textField.snp_makeConstraints { (make) in
                make.top.equalTo(5)
                make.bottom.equalTo(-5)
                make.left.equalTo(10)
                make.right.equalTo(-10)
                
            }
              navigationController!.navigationBar.addSubview(progressView)
            progressView.snp_makeConstraints { (make) in
                make.height.equalTo(1)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(0)
                
            }
            
            
            rewind.enabled = false
            forwardItem.enabled = false
            webView.addObserver(self, forKeyPath: "loading", options: NSKeyValueObservingOptions.New, context: nil)
            webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.New, context: nil)
            webView.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.New, context: nil)
            setupWKConfig()
            
        }
    
   // 创建了一个WKWebViewConfiguration对象，它拥有一些属性来作为原生代码和网页之间沟通的桥梁。JavaScript 代码被一个WKUserScript对象加载和包装。然后这个脚本被赋值给WKWebViewConfiguration对象的 userContentController属性，接着webView使用这个配置来初始化。
    private func setupWKConfig()
    {
        let  config = WKWebViewConfiguration()
        let scriptUrl  = NSBundle.mainBundle().pathForResource("getPost", ofType: "js")
        var scriptContent = " "
        do{
            scriptContent = try String(contentsOfFile: scriptUrl!, encoding: NSUTF8StringEncoding )
        }catch{
            print(error)
        }
        
        let script = WKUserScript(source: scriptContent, injectionTime: WKUserScriptInjectionTime.AtDocumentStart, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        config.userContentController.addScriptMessageHandler(self, name:MessageHandler )
        let url = NSURL(string: "http://www.cocoachina.com")
        webView.loadRequest(NSURLRequest(URL: url!))
        
    }
        private func padding() -> NSMutableAttributedString
        {
            let padding = NSMutableAttributedString(string: "\n\n")
            padding.font = UIFont.systemFontOfSize(4)
            return padding
            
        }
       
        private lazy var label:YYLabel = {
            let label = YYLabel()
            label.backgroundColor = UIColor.init(white: 0.9333, alpha: 1.0)
            label.numberOfLines = 0
            
            return label
        }()
    private lazy var webView:WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    private lazy var textField:UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.backgroundColor = UIColor.init(white: 0.000, alpha: 0.490)
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing
        textField.keyboardType = UIKeyboardType.WebSearch
        textField.returnKeyType = UIReturnKeyType.Go
        return textField
    }()

    private lazy var progressView:UIProgressView = {
        let pr = UIProgressView()
        pr.hidden = true
        return pr
    }()

}

extension ViewController
{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://"+textField.text!)!))
        return true
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "loading" {
            rewind.enabled = webView.canGoBack
            forwardItem.enabled = webView.canGoForward
        }else if keyPath == "estimatedProgress"{
            progressView.hidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        } else if keyPath == "title"{
            title = webView.title
        }
        
    }
    
    /**
     这个代理方法将会在有错误发生时被调用
     */
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        let  alter = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)

        alter.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alter, animated: true, completion: nil)
        
          progressView.setProgress(0.0, animated: true)
    }
    
    /**
     在网页加载时会被多次调用。其中一个参数WKNavigationAction对象 包含了帮助你决定是否让一个网页被加载的信息。在上面的代码中，我们使用其中两个属性，navigationType和request。我们只想中断被用户点击的外部链接的加载过程，所以我们检查了navigationType。然后我们检查了request的url来确认它是否是一个外部链接。如果两个条件都满足，这个url就会在用户的浏览器中打开（通常都是Safari）并且WKNavigationActionPolicy.Cancel终止了 App加载网页的过程。否则这个网页就会被加载并显示
     */
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == WKNavigationType.LinkActivated && navigationAction.request.URL!.host!.lowercaseString.hasPrefix("http://www.cocoachina.com"){
            UIApplication.sharedApplication().openURL(navigationAction.request.URL!)
            decisionHandler(WKNavigationActionPolicy.Cancel)
        }else{
            decisionHandler(WKNavigationActionPolicy.Allow)
        }
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage)
    {
        
        // js代码返回的数据
        if message.name == MessageHandler
        {
            if  let postsList:[AnyObject] = message.body as?[AnyObject]
            {
                for ps in postsList
                {
                    let post = Post(dictionary: ps as! [String:AnyObject])
                    posts.append(post)
                }
           }
    }
  }
}
