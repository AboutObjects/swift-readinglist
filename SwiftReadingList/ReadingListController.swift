//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import UIKit
import ReadingListModel

let TitleKey = "title"
let BooksKey = "books"

class ReadingListController : UITableViewController
{
    private let objectStore = ReadingListStore("BooksAndAuthors")
    private var books = [Book]()
    
    
    // MARK: - Unwind Segues
    
    @IBAction private func doneEditingBook(segue: UIStoryboardSegue)
    {
//        let controller = segue.sourceViewController as EditBookController
//        books.append(controller.book)
        tableView.reloadData()
        save()
    }
    
    @IBAction private func doneAddingBook(segue: UIStoryboardSegue)    { }
    @IBAction private func cancelEditingBook(segue: UIStoryboardSegue) { }
    @IBAction private func cancelAddingBook(segue: UIStoryboardSegue)  { }
    
    
    // MARK: - Updating Store
    
    private func save()
    {
        let dict = [TitleKey: title ?? "", BooksKey: books]
        let newReadingList = ReadingList(dictionary: dict as [String: AnyObject])
        
        objectStore.saveReadingList(newReadingList)
    }
    
    private func insertBook(book: Book, index: Int)
    {
        books.insert(book, atIndex:index)
        save()
        
        let indexPath = NSIndexPath(forRow:index, inSection:0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation:.Fade)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition:.Middle, animated:true)
    }
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var newReadingList = objectStore.readingList()
        books = newReadingList.books as [Book]
        
        title = newReadingList.title
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        switch (segue.identifier as NSString) {
//        case "ViewBook":
//            let controller = segue.destinationViewController as ViewBookController
//            controller.book  = books[tableView.indexPathForSelectedRow()!.row] as Book
//        case "AddBook":
//            let navController = segue.destinationViewController as UINavigationController
//            let controller = navController.childViewControllers.first as AddBookController
//            controller.completion = { book in self.insertBook(book, index:0) }
        default:
            println("Unmatched segue identifier \(segue.identifier)")
        }
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(
        tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.evenRowColor() : UIColor.oddRowColor()
        cell.imageView?.layer.cornerRadius = 22.0
        cell.imageView?.layer.masksToBounds = true
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(
        tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete {
            books.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            save()
        }
    }
    
    override func tableView(tableView: UITableView,
        moveRowAtIndexPath sourceIndexPath: NSIndexPath,
        toIndexPath destinationIndexPath: NSIndexPath)
    {
        let book = books[sourceIndexPath.row]
        books.removeAtIndex(sourceIndexPath.row)
        books.insert(book, atIndex: destinationIndexPath.row)
        tableView.moveRowAtIndexPath(sourceIndexPath, toIndexPath: destinationIndexPath)
        tableView.reloadData() // Update odd row highlighting
        save()
    }
    
    override func tableView(
        tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
        return books.count;
    }
    
    override func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookSummary") as UITableViewCell;
        let book: Book = books[indexPath.row] as Book
        
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.year + "  " + book.author!.fullName
        cell.imageView?.image = UIImage.imageNamed(book.author!.lastName, inBundleForClass:Book.self)
        
        return cell
    }
}

