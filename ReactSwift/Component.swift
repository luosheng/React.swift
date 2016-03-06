//
//  Component.swift
//  ReactSwift
//
//  Created by Luo Sheng on 16/3/5.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

import Foundation

public class Component<S: StateType, P: PropertyType> : Renderable {
    
    private var internalState: S?
    
    public var initialState: S? {
        get {
            return nil
        }
    }
    
    public var state: S? {
        get {
            return internalState ?? initialState
        }
        set {
            updateIfNecessary(nextProperty: internalProperty, nextState: newValue)
        }
    }
    
    private var internalProperty: P?
    
    public var defaultProperty: P? {
        get {
            return nil
        }
    }
    
    public var property: P? {
        get {
            return internalProperty ?? defaultProperty
        }
        set {
            updateIfNecessary(nextProperty: newValue, nextState: internalState)
        }
    }
    
    private func updateIfNecessary(nextProperty nextProperty: P?, nextState: S?) {
        guard shouldComponentUpdate(nextProperty: nextProperty, nextState: nextState) else {
                return
        }
        
        let previousProperty = property
        let previousState = state
        
        componentWillUpdate(nextProperty: nextProperty, nextState: nextState)
        
        internalProperty = nextProperty
        internalState = nextState
        
        renderInHostView()
        
        componentDidUpdate(previousProperty: previousProperty, previousState: previousState)
    }
    
    var hostView: UIView?
    
    var frame: CGRect?
    
    let children: [Component]
    
    public init(property: P?, children: [Component] = []) {
        internalProperty = property
        self.children = children
    }
    
    deinit {
        unmount()
    }
    
    public func render() -> Renderable? {
        return nil
    }
    
    public var view: UIView? {
        get {
            guard let renderable = self.render() else {
                return nil
            }
            
            if let renderable = renderable as? UIView {
                return renderable
            } else {
                return renderable.view
            }
        }
    }
    
    func mount() {
        componentWillMount()
        
        renderInHostView()
        
        componentDidMount()
    }
    
    func unmount() {
        guard let view = self.view else {
            return
        }
        
        componentWillUnmount()
        
        view.removeFromSuperview()
        
        componentDidUnmount()
    }
    
    private func renderInHostView() {
        guard let view = self.view else {
            return
        }
        
        hostView?.subviews.forEach { $0.removeFromSuperview() }
        hostView?.addSubview(view)
        if let frame = frame {
            view.frame = frame
        }
    }
    
    // MARK: - Life cycle
    
    public func componentWillMount() { }
    
    public func componentDidMount() { }
    
    public func shouldComponentUpdate(nextProperty nextProperty: PropertyType?, nextState: StateType?) -> Bool {
        return true
    }
    
    public func componentWillUpdate(nextProperty nextProperty: PropertyType?, nextState: StateType?) { }
    
    public func componentDidUpdate(previousProperty previousProperty: PropertyType?, previousState: StateType?) { }
    
    public func componentWillUnmount() { }
    
    public func componentDidUnmount() { }

}