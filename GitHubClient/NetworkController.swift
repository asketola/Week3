//
//  NetworkController.swift
//  GitHubClient
//
//  Created by Annemarie Ketola on 1/19/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

import UIKit

class NetworkController {
  
  class var sharedNetworkController : NetworkController {
    struct Static {
      static let instance : NetworkController = NetworkController()  // the let allows you to reun this once, and it set up for the rest of the time
    }
    return Static.instance
  }
  
  let clientSecret = "dglfkggdlkfggdgkl"
  let clientID = "SFSFFGDFGFDGFG"
  var urlSession : NSURLSession
  var accessToken : String

  
  init() {
    let ephemeralConfig = NSURLSessionConfiguration.ephemeralSessionConfiguration()
    
    self.urlSession = NSURLSession(configuration: ephemeralConfig)
     if let token = NSUserDefaults.objectForKey(<#NSUserDefaults#>)
  }

  
  func requestAccessToken() {
    let url = "https://github.com/login/oauth/authorize?client_id=\(self.clientID)&scope=user, repo"
    UIApplication.sharedApplication().openURL(NSURL (string: url)!)
  }
  
  func handleCallBackUrl(url: NSURL) {
    let code = url.query
    println(code!)
    
    // this is one way to pass back info in a POST, via passing items as paramters in a url
    
//    let oauthUrl = "https://github.com/login/oauth/access_token?\(code!)&client_secret=\(self.clientSecret)"
//    let postRequest = NSMutableURLRequest(URL: NSURL (string: oauthUrl)!)
//    postRequest.HTTPMethod = "POST"
//    //postRequest.HTTPBody
    
    // This is the 2nd way to pass back info with a POST, and this is passing back info in the body of a HTTP request
    
    let bodyString = "\(code!)&client_id=\(self.clientID)&client_scret=\(self.clientSecret)"
    let bodyData = bodyString.dataUsingEncoding
    (NSASCIIStringEncoding, allowLoddyConversion: true)
    let length = bodyData.length
    let postRequest = NSMutableURLRequest(URL: NSURL (string: "https://github.com/login/oauth/access_token")!)
    postRequest.HTTPMethod = "POST"
    postRequest.setValue("\(length)"
      forHTTPHeaderField: "Content-Length")
    postRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    postRequest.HTTPBody = bodyData

    
    let dataTask = self.urlSession.dataTaskWithRequest(postRequest, completionHandler: { (data, response, error) -> Void in
      
      if error == nil {
        if let httpResponse = response as?
          NSHTTPURLResponse {
            switch httpResponse.statusCode {
            case 200...299:
              let tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)
              println(tokenResponse)
              
              let accessTokenComponent = tokenResponse?.componentsSeparatedByString("&").first as String
              let accessToken = accessTokenComponent.componentsSeparatedByString("=").last
              println(accessToken!)
              
              NSUserDefaults.standardUserDefaults().synchronize()
              
            default:
              println("default case")
            }
        }
      }
      println(response)
    })
    dataTask.resume()
    
  }
  
  func fetchRepositoriesForSearchTerm(searchTerm : String, callback : ([AnyObject]?, String) -> (Void)) {
    
    
    let url = NSURL(string: "http://127.0.0.1.3000")
    
    let dataTask = self.urlSession.dataTaskWithURL(url!, completionHandler: { (data, urlResponse, error) -> Void in
      if error == nil {
        println(urlResponse)
      }
      })
    dataTask.resume()
  }
}
