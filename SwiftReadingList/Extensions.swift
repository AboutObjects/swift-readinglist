//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import UIKit

extension UIColor
{
    class func oddRowColor() -> UIColor
    {
        return UIColor(red: 0.96, green: 0.97, blue: 0.92, alpha: 1.0)
    }

    class func evenRowColor() -> UIColor
    {
        return UIColor(red: 1.0, green: 0.99, blue: 0.97, alpha: 1.0)
    }
    
    class func labelColor() -> UIColor
    {
        return UIColor(red: 0.25, green: 0.2, blue: 0.10, alpha: 1.0)
    }
}

extension UIImage
{
    class func imageNamed(name: NSString, inBundleForClass bundleClass: AnyClass?) -> UIImage?
    {
        let bundle = NSBundle(forClass: bundleClass.self)
        let image: UIImage? = UIImage(named:name, inBundle:bundle, compatibleWithTraitCollection:nil)
        return image != nil ? image : UIImage(named:"NoImage", inBundle:bundle, compatibleWithTraitCollection:nil)
    }
}