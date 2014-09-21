//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

public class ModelObject: NSObject
{
    // TODO: Ideally, keys would be a class variable, but that feature
    // isn't yet supported in the current version of Swift.
    //
    //     class let keys = []
    //
    class func keys() -> [String]
    {
        return []
    }
    
    public required init(dictionary: [String: AnyObject])
    {
        super.init()
        self.setValuesForKeysWithDictionary(dictionary)
    }
    
    public func dictionaryRepresentation() -> [NSObject: AnyObject]
    {
        let keys = self.dynamicType.keys()
        return self.dictionaryWithValuesForKeys(keys)
    }
}