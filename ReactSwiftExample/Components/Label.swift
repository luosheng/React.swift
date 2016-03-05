//
//  Label.swift
//  ReactSwift
//
//  Created by Luo Sheng on 16/3/5.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

import UIKit
import ReactSwift

struct LabelState : StateType { }

struct LabelProperty : PropertyType {
    let text: String
}

class Label : BaseComponent<LabelState, LabelProperty> {
    
    init(property: LabelProperty) {
        super.init(property: property)
    }
    
    override func render() -> Renderable? {
        let label = UILabel()
        if let property = property {
            label.text = property.text
        }
        return label
    }
    
}