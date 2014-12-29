//
//  CreditPerson.swift
//  TabBarExampleApp
//
//  Created by Nicolas on 12/22/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

import UIKit

class CreditPerson: NSObject
{
    var personName : NSString = ""
    var personRole : NSString = ""
    
    override init()
    {
        
    }
    
    func setData(name : NSString, role : NSString)
    {
        personName = name
        personRole = role
    }
    
}
