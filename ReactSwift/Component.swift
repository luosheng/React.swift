//
//  Component.swift
//  ReactSwift
//
//  Created by Luo Sheng on 16/3/5.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

import Foundation

protocol Component : Renderable {
    
    var delegate: ComponentDelegate? { get set }
    
    var hostView: UIView? { get set }
    
    var frame: CGRect? { get set }
    
}

public class BaseComponent<S: StateType, P: PropertyType> : Component, ComponentDelegate {
    
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
            updateIfNecessary(internalProperty, nextState: newValue)
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
            updateIfNecessary(newValue, nextState: internalState)
        }
    }
    
    private func updateIfNecessary(nextProperty: P?, nextState nextState: S?) {
        guard let shouldUpdate = delegate?.shouldComponentUpdate(nextProperty: nextProperty, nextState: nextState)
            where shouldUpdate
            else {
                return
        }
        
        let previousProperty = property
        let previousState = state
        
        delegate?.componentWillUpdate(nextProperty: nextProperty, nextState: nextState)
        
        internalProperty = nextProperty
        internalState = nextState
        
        renderInHostView()
        
        delegate?.componentDidUpdate(previousProperty: previousProperty, previousState: previousState)
    }
    
    public var delegate: ComponentDelegate?
    
    var hostView: UIView?
    
    var frame: CGRect?
    
    public init(property: P?) {
        internalProperty = property
        delegate = self
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
    
    func install() {
        delegate?.componentWillMount()
        renderInHostView()
        delegate?.componentDidMount()
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
    
    public func componentWillMount() { }
    
    public func componentDidMount() { }
    
    public func shouldComponentUpdate(nextProperty nextProperty: PropertyType?, nextState: StateType?) -> Bool {
        return true
    }
    
    public func componentWillUpdate(nextProperty nextProperty: PropertyType?, nextState: StateType?) { }
    
    public func componentDidUpdate(previousProperty previousProperty: PropertyType?, previousState: StateType?) { }

}