//
//  LifeCycle.swift
//  ReactSwift
//
//  Created by Luo Sheng on 16/3/5.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

import Foundation

public protocol ComponentDelegate {
    
    func componentWillMount()
    
    func componentDidMount()
    
    func shouldComponentUpdate(nextProperty nextProperty: PropertyType?, nextState: StateType?) -> Bool
    
    func componentWillUpdate(nextProperty nextProperty: PropertyType?, nextState: StateType?)
    
    func componentDidUpdate(previousProperty previousProperty: PropertyType?, previousState: StateType?)
    
}