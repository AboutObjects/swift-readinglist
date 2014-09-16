//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

public class ModelObject: NSObject
{
    // TODO: Ideally, keys would be a class variable, but that feature
    // hasn't yet been implemented in the current version of Swift.
    //
    //     class let keys = []
    //
    class func keys() -> [String]
    {
        return []
    }
    
    public init(dictionary: [String: AnyObject])
    {
        super.init()
        self.setValuesForKeysWithDictionary(dictionary)
    }
    
    public func dictionaryRepresentation() -> [NSObject: AnyObject]
    {
        return self.dictionaryWithValuesForKeys(self.dynamicType.keys())
    }
}