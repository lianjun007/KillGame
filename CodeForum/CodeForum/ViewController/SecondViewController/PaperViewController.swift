//
//  PaperViewController.swift
//  CodeForum
//
//  Created by QHuiYan on 2023/6/3.
//

import UIKit
import WebKit

class LocalFileURLSchemeHandler: NSObject, WKURLSchemeHandler {
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        guard let url = urlSchemeTask.request.url else {
            return
        }

        let fileManager = FileManager.default
        let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileUrl = documentDirectory.appendingPathComponent(url.path)

        guard fileManager.fileExists(atPath: fileUrl.path) else {
            return
        }

        let data = try! Data(contentsOf: fileUrl)
        let mimeType = "text/html"
        let response = URLResponse(url: url, mimeType: mimeType, expectedContentLength: data.count, textEncodingName: nil)

        urlSchemeTask.didReceive(response)
        urlSchemeTask.didReceive(data)
        urlSchemeTask.didFinish()
    }

    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {}
}



class LocalFileURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        if request.url?.scheme == "local" {
            return true
        }
        return false
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        let url = self.request.url!
        let path = url.path.replacingOccurrences(of: "/local", with: "")
        let data = NSData(contentsOfFile: path)
        let mimeType = "text/html"
        let encoding = "UTF-8"

        let response = URLResponse(url: url, mimeType: mimeType, expectedContentLength: data!.length, textEncodingName: encoding)
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        self.client?.urlProtocol(self, didLoad: data! as Data)
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}




class PaperViewController: UIViewController {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "精选文章的标题大家你是他的好挑食的剪完头"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        

        let webView = WKWebView(frame: self.view.bounds)
        view.addSubview(webView)
        webView.backgroundColor = .systemBackground
        
        webView.configuration.setURLSchemeHandler(LocalFileURLSchemeHandler(), forURLScheme: "local")

        let url = Bundle.main.url(forResource: "index", withExtension: "html")!
        let folderPath = Bundle.main.resourcePath!
        let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
        webView.loadFileURL(url, allowingReadAccessTo: baseUrl)




    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        self.navigationController?.navigationBar.subviews.forEach({ (view) in
    //            if !view.isKind(of: NSClassFromString("_UINavigationBarContentView")!) {
    //                view.isHidden = true
    //
    //            }
    //        })
    //
    //    }
    //
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        self.navigationController?.navigationBar.subviews.forEach({ (view) in
    //            if !view.isKind(of: NSClassFromString("_UINavigationBarContentView")!) {
    //                view.isHidden = false
    //            }
    //        })
    //
    //    }
    
}
