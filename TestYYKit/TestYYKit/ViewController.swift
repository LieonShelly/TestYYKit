//
//  ViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/7/25.
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
// swiftlint:disable statement_position
// swiftlint:disable trailing_whitespace
// swiftlint:disable trailing_whitespace

import UIKit
import SnapKit
import SVProgressHUD
import WebKit
import YYText

let MessageHandler = "didGetPosts"

class ViewController: UIViewController ,UITextFieldDelegate,WKNavigationDelegate,WKScriptMessageHandler{

    @IBOutlet weak var rewind: UIBarButtonItem!
    
    @IBOutlet weak var forwardItem: UIBarButtonItem!
    
    @IBOutlet weak var refreashItem: UIBarButtonItem!
    var  posts:[Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        // 2.测试webKit
        setupLabel()
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
            
            label.attributedText = creatAttributeString()
            view.addSubview(label)
            label.textAlignment = NSTextAlignment.Center
            label.textVerticalAlignment = YYTextVerticalAlignment.Center
            label.snp_makeConstraints { (make) in
                make.center.equalTo(view.snp_center)
                make.width.equalTo(view.snp_width)
                make.height.equalTo(40)
            }
            
            textLabel.attributedText = creatAttributeString()
            
            view.addSubview(textLabel)
            textLabel.snp_makeConstraints { (make) in
                make.left.equalTo(0)
                make.top.equalTo(90)
                make.right.equalTo(-20)
                make.height.equalTo(50)
            }
            

       }
    private func creatAttributeString() -> NSMutableAttributedString {
        
        let text = NSMutableAttributedString()
        let one = NSMutableAttributedString(string: "本次sdfsdfsdfsnsbndfasnfns服务已经结束，请对此次服务做")
        one.yy_alignment = .Center
        one.yy_font = UIFont.systemFontOfSize(14)
        one.yy_color = UIColor.blackColor()
        one.yy_lineSpacing = 5
        text.appendAttributedString(one)
        
        let two = NSMutableAttributedString(string: "  评价 ")
        two.yy_font = UIFont.systemFontOfSize(17)
        two.yy_underlineStyle = NSUnderlineStyle.StyleSingle
        two.yy_lineSpacing = 5
        two.yy_alignment = .Center
        
        let  border = YYTextBorder(fillColor: UIColor.grayColor(), cornerRadius: 3)
        
        let hightlight = YYTextHighlight()
        hightlight.setColor(UIColor.whiteColor())
        hightlight.setBackgroundBorder(border)
        hightlight.tapAction = {(_, _, _, _) in
            print("我被搞了")
        }
        two.yy_setTextHighlight(hightlight, range: two.yy_rangeOfAll())
        text.appendAttributedString(two)
        return text
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
      
       
        private lazy var label:YYLabel = {
            let label = YYLabel()
            label.backgroundColor = UIColor.init(white: 0.9333, alpha: 1.0)
            label.numberOfLines = 0
            
            return label
        }()
    
    private lazy var textLabel: YYLabel = {
        let label = YYLabel()
        label.userInteractionEnabled = true
        label.textAlignment = NSTextAlignment.Center
        label.backgroundColor = UIColor.redColor()
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
