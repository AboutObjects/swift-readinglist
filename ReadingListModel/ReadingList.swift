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
    
    public override init(var dictionary: [String : AnyObject])
    {
        if contains((dictionary.keys), BooksKey)
        {
            dictionary[BooksKey] = booksFromDictionaries(dictionary[BooksKey]! as [AnyObject])
        }
        
        super.init(dictionary: dictionary)
    }
    
    public override func dictionaryRepresentation() -> [NSObject: AnyObject]
    {
        var dictionary = super.dictionaryRepresentation() as [String: AnyObject]
        
        let values: AnyObject? = dictionary[BooksKey]
        if let books = values as? [ModelObject]
        {
            dictionary[BooksKey] = dictionariesFromModelObjects(books)
        }
        
        return dictionary
    }
}