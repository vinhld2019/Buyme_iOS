//
//  ViewUtils.swift
//  Buyme
//
//  Created by Vinh LD on 2/13/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import Kingfisher

class ViewUtils: NSObject {
    
    static let shared = ViewUtils()
    
    func shareScreenShot(_ view: UIView, baseVC: UIViewController, height: CGFloat = 0, completionHandler: @escaping (UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Void) {
        let image = createScreenShot(view, height: height)
        
        let imageToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = baseVC.view
        
        activityViewController.completionWithItemsHandler = { type, compile, data, error in
            completionHandler(type, compile, data, error)
            if type != nil {
                if compile {
                    //success
                } else {
                    //failed
                }
            }
        }
        
        baseVC.present(activityViewController, animated: true, completion: nil)
    }
    
    func createScreenShot(_ view: UIView, height: CGFloat = 0) -> UIImage {
        if let tableView = view as? UITableView {
            return renderTableviewScreenshot(tableView)
        }
        
        if let collectionView = view as? UICollectionView {
            return renderCollectionviewScreenshot(collectionView)
        }
        
        if let scrollView = view as? UIScrollView, let subview = scrollView.subviews.first {
            return createScreenShot(subview)
        }
        
        UIGraphicsBeginImageContext(CGSize(width: UIScreen.main.bounds.size.width, height: view.bounds.size.height + height))
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    private func renderTableviewScreenshot(_ myTableView: UITableView) -> UIImage {
        myTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        UIGraphicsBeginImageContext(myTableView.contentSize)
        if let context = UIGraphicsGetCurrentContext() {
            myTableView.layer.render(in: context)
        }
        
        for section in (0..<myTableView.numberOfSections) {
            for row in (0..<myTableView.numberOfRows(inSection: section)) {
                myTableView.scrollToRow(at: IndexPath(row: row, section: section), at: .top, animated: false)
                if let context = UIGraphicsGetCurrentContext() {
                    myTableView.layer.render(in: context)
                }
            }
        }
        myTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    private func renderCollectionviewScreenshot(_ myCollectionView: UICollectionView) -> UIImage {
        myCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        UIGraphicsBeginImageContext(myCollectionView.contentSize)
        if let context = UIGraphicsGetCurrentContext() {
            myCollectionView.layer.render(in: context)
        }
        
        for section in (0..<myCollectionView.numberOfSections) {
            for row in (0..<myCollectionView.numberOfItems(inSection: section)) {
                myCollectionView.scrollToItem(at: IndexPath(row: row, section: section), at: .top, animated: false)
                if let context = UIGraphicsGetCurrentContext() {
                    myCollectionView.layer.render(in: context)
                }
            }
        }
        myCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}

extension UIView {
    
    var superSuperview: UIView {
        if let view = superview {
            return view.superSuperview
        }
        return self
    }
    
    var superX: CGFloat {
        let originX = frame.origin.x
        if let superview = superview {
            return originX + superview.superX
        }
        
        return originX
    }
    
    var superY: CGFloat {
        let originY = frame.origin.y
        if let superview = superview {
            return originY + superview.superY
        }
        
        return originY
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            DispatchQueue.main.async {
                self.layer.cornerRadius = newValue
                self.clipsToBounds = newValue > 0
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return .init(cgColor: color)
            }
            return  nil
        }
        set {
            DispatchQueue.main.async {
                self.layer.borderColor = newValue?.cgColor
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set {
            DispatchQueue.main.async {
                self.layer.borderWidth = newValue
            }
        }
    }
}

extension UIButton {
    func selectCheckBox(checked: Bool) {
        setImage(UIImage(named: checked ? "IHCheckBox" : "IHCheckedBox"), for: .normal)
    }
}

extension UILabel {
    func fitToWitdh(minimumScaleFactor: CGFloat = 0.5) {
        self.minimumScaleFactor = minimumScaleFactor
        self.adjustsFontSizeToFitWidth = true
    }
}

class Label: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.fitToWitdh()
    }
}

class TextField: UITextField {
    
    var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension UIImageView {
    
    var base64: String? {
        if let image = self.image {
            let jpgData = image.jpegData(compressionQuality: 0.5)
            if let coding = jpgData?.base64EncodedString() {
                return "data:image/jpg;base64,\(coding)"
            }
        }
        return nil
    }
    
    func setImage(link: String) {
        if let url = URL(string: link) {
            self.kf.setImage(with: url)
        }
    }
}
