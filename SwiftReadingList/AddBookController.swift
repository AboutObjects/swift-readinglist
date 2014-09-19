//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import UIKit
import ReadingListModel

class AddBookController : UITableViewController
{
    var book: Book!
    var completion: ((book: Book) -> Void)?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!

    var bookToAdd: Book {
        return Book(dictionary:["title": titleField.text, "year": yearField.text,
            "author":["firstName": firstNameField.text, "lastName": lastNameField.text]])
    }
    
    
    // MARK: - UIViewController
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        titleField.becomeFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if segue.identifier == "DoneAddingBook" {
            completion? (book: bookToAdd)
        }
    }
}
