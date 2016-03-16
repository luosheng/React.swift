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
            updateIfNecessary(newValue)
        }
    }
    
    private let internalProperty: P?
    
    public var defaultProperty: P? {
        get {
            return nil
        }
    }
    
    public var property: P? {
        get {
            return internalProperty ?? defaultProperty
        }
    }
    
    private func updateIfNecessary(nextState: S?) {
        guard shouldComponentUpdate(nextState) else {
                return
        }
        
        let previousProperty = property
        let previousState = state
        
        componentWillUpdate(nextState)
        
        internalState = nextState
        
        renderInHostView()
        
        componentDidUpdate(previousState)
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
    
    private var renderedView: UIView?
    
    private func renderInHostView() {
        renderedView?.removeFromSuperview()
        
        guard let view = self.view else {
            return
        }
        
        renderedView = view
        hostView?.addSubview(view)
        
        if let layout = self.property?.style?.layout() {
            layout.apply(view)
        }
    }
    
    // MARK: - Life cycle
    
    public func componentWillMount() { }
    
    public func componentDidMount() { }
    
    public func shouldComponentUpdate(nextState: StateType?) -> Bool {
        return true
    }
    
    public func componentWillUpdate(nextState: StateType?) { }
    
    public func componentDidUpdate(previousState: StateType?) { }
    
    public func componentWillUnmount() { }
    
    public func componentDidUnmount() { }

}