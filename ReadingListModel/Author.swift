//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

public class Author: ModelObject
{
    public var firstName = ""
    public var lastName = ""
    
    public var fullName: String {
        return (firstName + " " + lastName).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    public override var description: String {
        return fullName
    }
    
    override class func keys() -> [String]
    {
        return ["firstName", "lastName"]
    }
}