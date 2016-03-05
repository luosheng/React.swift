//
//  React.swift
//  ReactSwift
//
//  Created by Luo Sheng on 16/3/5.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

import Foundation

struct Renderer {
    
    static func render<S: StateType, P: PropertyType>(component: BaseComponent<S, P>, hostView: UIView, frame: CGRect) {
        component.hostView = hostView
        component.frame = frame
        component.install()
    }
    
}