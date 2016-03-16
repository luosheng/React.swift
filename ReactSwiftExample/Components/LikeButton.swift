//
//  LikeButton.swift
//  ReactSwift
//
//  Created by Luo Sheng on 16/3/6.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

import Foundation
import ReactSwift
import SwiftBox

struct LikeButtonState : StateType {
    
    let liked: Bool
    
}

struct LikeButtonProperty : PropertyType {
    
    var style: Node? {
        get {
            return nil
        }
    }
    
}

final class LikeButton : Component<LikeButtonState, LikeButtonProperty> {
    
    init() {
        super.init(property: LikeButtonProperty())
    }
    
    override var initialState: LikeButtonState? {
        get {
            return LikeButtonState(liked: false)
        }
    }
    
    @objc func handleTap(sender: AnyObject) {
        guard let s = state else {
            return
        }
        
        state = LikeButtonState(liked: !s.liked)
    }
    
    override func render() -> Renderable? {
        let button = UIButton()
        if let state = state {
            let text = state.liked ? "like" : "haven't liked"
            button.setTitle("You \(text) this. Tap to toggle.", forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.backgroundColor = UIColor.redColor()
            button.addTarget(self, action: #selector(handleTap(_:)), forControlEvents: .TouchUpInside)
        }
        return button
    }
    
}