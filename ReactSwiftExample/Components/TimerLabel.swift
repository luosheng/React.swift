//
//  TimerLabel.swift
//  ReactSwift
//
//  Created by Luo Sheng on 16/3/5.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

import UIKit
import ReactSwift
import SwiftBox

struct TimerState: StateType {
    let date: NSDate
}

struct TimerProperty: PropertyType {

    var style: Node? {
        get {
            return Node(size: CGSize(width: 400, height: 20), selfAlignment: .Center, flex: 1)
        }
    }
    
}

final class TimerLabel: Component<TimerState, TimerProperty> {
    
    var timer: NSTimer?
    
    init() {
        super.init(property: TimerProperty())
    }
    
    override var initialState: TimerState? {
        get {
            return TimerState(date: NSDate())
        }
    }
    
    override func componentDidMount() {
        timer = NSTimer(timeInterval: 1, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    @objc func fire() {
        self.state = TimerState(date: NSDate())
    }
    
    override func render() -> Renderable? {
        guard let state = state else {
            return nil
        }
        
        let dateString = NSDateFormatter.localizedStringFromDate(state.date, dateStyle: .ShortStyle, timeStyle: .MediumStyle)
        return Label(property: LabelProperty(text: dateString))
    }
    
}