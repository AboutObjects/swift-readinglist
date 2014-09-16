//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

extension NSArray
{
    func toBooks() -> [Book]
    {
        return map(self, {
            (currObj: AnyObject) -> Book in
            return Book(currObj)
        })
    }
}


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
        return ["title", "books"]
    }
    
    public override init(dictionary: [String : AnyObject])
    {
        self.title = dictionary["title"] as NSString ?? ""
        
        super.init(dictionary: dictionary)
        
        if contains((dictionary.keys), "books") {
            precondition(dictionary["books"] is NSArray, "books must be an array.")
            self.books = (dictionary["books"] as NSArray).toBooks()
        }
    }
    
    public override func dictionaryRepresentation() -> [NSObject : AnyObject]
    {
        var readingListDict = super.dictionaryRepresentation()

        if let books = readingListDict["books"] as? NSArray {
            readingListDict["books"] = map(books, {
                (book: AnyObject) -> [NSObject: AnyObject] in
                return book.dictionaryRepresentation()
            })
        }
        return readingListDict
    }
}