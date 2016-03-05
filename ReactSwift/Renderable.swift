//
//  Renderable.swift
//  ReactSwift
//
//  Created by Luo Sheng on 16/3/5.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

import Foundation

public protocol Renderable {
    
    func render() -> Renderable?
    
    var view: UIView? { get }
    
}

extension UIView : Renderable {
    
    public func render() -> Renderable? {
        return self
    }
    
    public var view: UIView? {
        get {
            return nil
        }
    }
    
}