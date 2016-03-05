//
//  React.swift
//  ReactSwift
//
//  Created by Luo Sheng on 16/3/5.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

import Foundation

public struct Renderer {
    
    public static func render<S: StateType, P: PropertyType>(component: Component<S, P>, hostView: UIView, frame: CGRect) {
        component.hostView = hostView
        component.frame = frame
        component.install()
    }
    
}