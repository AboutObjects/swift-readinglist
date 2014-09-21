//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

let BooksKey = "books"

public class ReadingList: ModelObject
{
    public var title = ""
    public var books = [Book]()
    
    public override var description: String {
        var s = "Title: \(title)\nCount: \(books.count)\nBooks:\n------\n"
        for (index, book: Book) in enumerate(books) {
            s += "\(index + 1). \(book)\n"
        }
        return s
    }
    
    override class func keys() -> [String]
    {
        return [TitleKey, BooksKey]
    }
    
    public override func setValue(var value: AnyObject!, forKey key: String!)
    {
        if (key == BooksKey && value is [[String: AnyObject]])
        {
            value = map(value as [[String: AnyObject]], { Book.self(dictionary: $0) })
        }
        
        super.setValue(value, forKey: key)
    }
    
    public override func dictionaryRepresentation() -> [NSObject: AnyObject]
    {
        var dictionary = super.dictionaryRepresentation() as [String: AnyObject]
        
        let values: AnyObject? = dictionary[BooksKey]
        if let books = values as? [ModelObject]
        {
            dictionary[BooksKey] = map(books, { $0.dictionaryRepresentation() })
        }
        
        return dictionary
    }
}