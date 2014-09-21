//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation


func toDictionaries(modelObjects: [ModelObject]) -> [NSDictionary]
{
    return map(modelObjects, { $0.dictionaryRepresentation() })
    
//    return map(modelObjects, { (modelObject: AnyObject) -> NSDictionary in
//        return modelObject.dictionaryRepresentation()
//    })
}

func toModelObjects(dictionaries: [[String: AnyObject]], type: ModelObject.Type) -> [ModelObject]
{
    return map(dictionaries, { type(dictionary: $0) })

//    return map(dictionaries, { (currObj: AnyObject) -> ModelObject in
//        return type(object: currObj)
//    })
}


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
    
    public required init(dictionary: [String: AnyObject])
    {
        super.init()
        self.setValuesForKeysWithDictionary(dictionary)
    }
    
//    public required convenience init(object: AnyObject)
//    {
//        precondition(object is ModelObject || object is [String: AnyObject],
//            "Argument must match type ModelObject or [String: AnyObject].")
//        
//        var values: [String: AnyObject]?
//        
//        if let dict = object as? [String: AnyObject] {
//            values = dict
//        }
//        else if let book = object as? Book {
//            values = book.dictionaryRepresentation() as? [String: AnyObject]
//        }
//        
//        self.init(dictionary: values!)
//    }
    
    public func dictionaryRepresentation() -> [NSObject: AnyObject]
    {
        let keys = self.dynamicType.keys()
        return self.dictionaryWithValuesForKeys(keys)
    }
}