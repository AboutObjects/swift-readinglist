//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import UIKit
import XCTest
import ReadingListModel

let FirstNameKey = "firstName"
let LastNameKey = "lastName"
let FirstName1 = "Fred"
let LastName1 = "Smith"
let AuthorDict1 = [FirstNameKey: FirstName1, LastNameKey: LastName1]

let TitleKey = "title"
let YearKey = "year"
let AuthorKey = "author"
let Title1 = "My Book" as NSString
let Title2 = "Your Book"
let Year1 = "1999" as NSString
let Year2 = "2012"
let BookDict1 = [TitleKey: Title1, YearKey: Year1, AuthorKey: AuthorDict1]
let BookDict2 = [TitleKey: Title2, YearKey: Year2, AuthorKey: AuthorDict1]

let BooksKey = "books"
let ReadingListTitle1 = "First Reading List Title" as NSString
let ReadingListTitle2 = "Second Reading List Title" as NSString
let ReadingListDict1 = [TitleKey: ReadingListTitle1, BooksKey: [BookDict1]]
let ReadingListDict2 = [TitleKey: ReadingListTitle2, BooksKey: [BookDict1, BookDict2]]

let StoreName = "BooksAndAuthors" as NSString

class ReadingListModelTests: XCTestCase
{
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitializeAuthorWithDictionary()
    {
        let dict = AuthorDict1
        let author = Author(dictionary: dict)
        println("\(author)")
        
        XCTAssertEqual(author.firstName, dict[FirstNameKey]!, "")
        XCTAssertEqual(author.lastName, dict[LastNameKey]!, "")
    }
    
    func testInitializeBookWithDictionary()
    {
        let dict: [String: AnyObject] = BookDict1 as [String: AnyObject]
        let book = Book(dictionary: dict)
        println("\(book)")
        
        XCTAssertEqual(book.title, dict[TitleKey] as NSString ?? "", "")
        
        let myDict: AnyObject? = dict[AuthorKey]
        let authorDict: [String: AnyObject] = myDict as [String: AnyObject]
        XCTAssertEqual(book.author!.firstName, authorDict[FirstNameKey]! as String, "")
    }
    
    func testInitializeReadingListWithDictionary()
    {
        let readingList = ReadingList(dictionary: ReadingListDict1)
        println("\(readingList)")
        
        let readingList2 = ReadingList(dictionary: ReadingListDict2)
        println("\(readingList2)")
        
        let firstBook: AnyObject = readingList.books[0]
        XCTAssert(firstBook is Book, "Book dictionary should have been converted to instance of Book")
        
        let value = ReadingListDict2[BooksKey]
        let bookDicts = value as [[String: AnyObject]]
        XCTAssertEqual(readingList2.books.count, bookDicts.count, "")
    }
    
    func XXXtestMapReduce()
    {
        let readingList2 = ReadingList(dictionary: ReadingListDict2)
        println("\(readingList2)")
        
        var count1 = 0
        let a = map(readingList2.books, {(book: Book) -> String in
            count1++
            return "\n\(count1). \(book)"
        })
        
        var s = ""
        var count2 = 0
        let b = reduce(readingList2.books, s) {(s, book: Book) -> String in
            count2++
            return s + "\n\(count2). \(book)"
        }
        println("\(a)")
        println("\(b)")
    }
    
    
    func testAuthorDictionaryRepresentation()
    {
        let author = Author(dictionary: AuthorDict1)
        let dict = author.dictionaryRepresentation()
        
        println("\(dict)")
        XCTAssertEqual(author.firstName, AuthorDict1[FirstNameKey]!, "")
        XCTAssertEqual(author.lastName, AuthorDict1[LastNameKey]!, "")
    }
    
    func testBookDictionaryRepresentation()
    {
        let book = Book(dictionary: BookDict1)
        let dict = book.dictionaryRepresentation()
        
        println("\(dict)")
        XCTAssertEqual(book.author!.firstName, AuthorDict1[FirstNameKey]!, "")
        XCTAssertEqual(book.title, BookDict1[TitleKey]!, "")
        XCTAssertEqual(book.year, BookDict1[YearKey]!, "")
    }
    
    func testReadingListDictionaryRepresentation()
    {
        let readingList = ReadingList(dictionary: ReadingListDict2)
        let dict = readingList.dictionaryRepresentation()
        
        println("\(dict)")
        XCTAssertEqual(readingList.title, ReadingListDict2[TitleKey]!, "")
        XCTAssertEqual(readingList.books.count, (ReadingListDict2[BooksKey]! as NSArray).count, "")
    }
    
    func testWriteReadingListToFile()
    {
        let readingList = ReadingList(dictionary: ReadingListDict2)
        let dict = readingList.dictionaryRepresentation() as NSDictionary
        
        dict.writeToFile("/tmp/ReadingList.plist", atomically: true)
        
        let dict2 = NSDictionary(contentsOfFile: "/tmp/ReadingList.plist")
        println("\(dict2)")
        
        let readingList2 = ReadingList(dictionary: dict2 as [String: AnyObject])
        println("\(readingList2)")
        
        XCTAssertEqual((readingList.books[0] as Book).title, (readingList2.books[0] as Book).title, "")
        XCTAssertEqual((readingList.books[0] as Book).year, (readingList2.books[0] as Book).year, "")
        XCTAssertEqual((readingList.books[0] as Book).author!.lastName, (readingList2.books[0] as Book).author!.lastName, "")
        XCTAssertEqual((readingList.books[1] as Book).title, (readingList2.books[1] as Book).title, "")
        XCTAssertEqual((readingList.books[1] as Book).year, (readingList2.books[1] as Book).year, "")
        XCTAssertEqual((readingList.books[1] as Book).author!.lastName, (readingList2.books[1] as Book).author!.lastName, "")
    }
    
    func testCreateStoreWithName()
    {
        let store = ReadingListStore(StoreName)
        println("In \(__FUNCTION__): store is \(store)")
        XCTAssertNotNil(store, "Store should not be nil")
    }
    
    
    func testLoadData()
    {
        let store = ReadingListStore(StoreName)
        let expected = store.readingList()
        println("In \(__FUNCTION__): reading list is \(expected)")
    }
}
