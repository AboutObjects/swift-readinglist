//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

let TitleKey = "title"
let YearKey = "year"
let AuthorKey = "author"

let Unknown = "unknown"

public class Book: ModelObject
{
    public var title = ""
    public var year = ""
    public var author: Author?
    
    public override var description: String {
        return "\(title), \(year), \(author ?? Unknown)"
    }
    
    override class func keys() -> [String]
    {
        return [TitleKey, YearKey, AuthorKey]
    }
    
    public required init(var dictionary: [String : AnyObject])
    {
        let value: AnyObject? = dictionary[AuthorKey]
        
        if let dict = value as? [String: AnyObject]
        {
            dictionary[AuthorKey] = Author(dictionary: dict)
        }
        
        super.init(dictionary: dictionary)
    }
    
    public override func dictionaryRepresentation() -> [NSObject: AnyObject]
    {
        var dictionary = super.dictionaryRepresentation() as [String: AnyObject]
        
        if let author = dictionary[AuthorKey] as? Author
        {
            dictionary[AuthorKey] = author.dictionaryRepresentation()
        }
        
        return dictionary
    }
}