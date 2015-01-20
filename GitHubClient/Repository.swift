//
//  Repository.swift
//  GitHubClient
//
//  Created by Annemarie Ketola on 1/19/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

import Foundation

struct Repository {
  let name : String
  let author : String
 
  init(jsonDictionary : [String : AnyObject]) {
    self.name = jsonDictionary["name"] as String
    self.author = "Brad"
  }
}
