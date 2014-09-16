//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

public class Book: ModelObject
{
    let unknown = "unknown"
    
    public var title = ""
    public var year = ""
    public var author: Author?
    
    public override var description: String {
        return "\(title), \(year), \(author ?? unknown)"
    }
    
    override class func keys() -> [String]
    {
        return ["title", "year", "author"]
    }
    
    public convenience init(_ some: AnyObject)
    {
        precondition(some is Book || some is [String: AnyObject],
            "Argument must match types Book or [String: AnyObject].")
        
        var values: [String: AnyObject]?
        if let dict = some as? [String: AnyObject] {
            values = dict
        }
        else if let book = some as? Book {
            values = book.dictionaryRepresentation() as? [String: AnyObject]
        }
        
        self.init(dictionary: values!)
    }
    
    public override init(dictionary: [String : AnyObject])
    {
        var mutableDict = dictionary
        if let authorDict = dictionary["author"] as? NSDictionary {
            let authorDict = authorDict as? [String: AnyObject]
            mutableDict["author"] = Author(dictionary: authorDict!)
        }
        super.init(dictionary: mutableDict)
    }
    
    public override func dictionaryRepresentation() -> [NSObject : AnyObject]
    {
        var mutableDict = super.dictionaryRepresentation()
        if let author = mutableDict["author"] as? Author {
            mutableDict["author"] = author.dictionaryRepresentation()
        }
        return mutableDict
    }
}