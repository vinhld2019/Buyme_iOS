//
//  CartView.swift
//  Buyme
//
//  Created by Vinh LD on 11/26/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class CartView {
    
    static let shared: CartView = CartView()
    
    var button: UIButton = UIButton()
    
    func setup() {
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:))))
        setButtonAction()
    }
    
    func setButtonAction() {
        AppUtils.shared.navigationController!.view.addSubview(button)
        button.setTitle("Touch me", for: .normal)
        button.setImage(UIImage(named: "Cart"), for: .normal)
//        button.setImage(#imageLiteral(resourceName: "Message"), for: .selected)
        let view = AppUtils.shared.navigationController!.view
        let width = view!.bounds.size.width
        let height = view!.bounds.size.height
        button.frame = CGRect(x: width - 60, y: height - 160, width: 60, height: 60)
        button.removeTarget(nil, action: nil, for: .allEvents)
        button.addTarget(self, action: #selector(showPopoverAction(sender:)), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 1.0
    }
    
    func dismiss(animated: Bool) {
        print("dismiss")
    }
    
    @objc func draggedView(_ sender: UIPanGestureRecognizer) {
        
        button.isSelected = false
        
        let view = AppUtils.shared.navigationController!.view
        let translation = sender.translation(in: view)
        let width = view!.bounds.size.width
        let height = view!.bounds.size.height
        
        button.center = CGPoint(x: button.center.x + translation.x, y: button.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
        
        if sender.state == .ended {
            
            if button.frame.origin.y < 100 {
                button.frame.origin.y = 100
            } else if button.frame.origin.y > height - 160 {
                button.frame.origin.y = height - 160
            }
            let moveRight = button.center.x > width/2
            UIView.animate(withDuration: 0.3, animations: {
                self.button.frame.origin.x = moveRight ? width - 60 : 0
            })
        }
    }
    
    @objc func showPopoverAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        Mics.shared.log("Touch up inside")
    }
}
