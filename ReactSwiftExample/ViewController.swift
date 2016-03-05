//
//  ViewController.swift
//  ReactSwiftExample
//
//  Created by Luo Sheng on 16/3/5.
//  Copyright © 2016年 Luo Sheng. All rights reserved.
//

import UIKit
import ReactSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = Label(property: LabelProperty(text: "Hello world"))
        Renderer.render(label, hostView: view, frame: CGRect(x: 0, y: 100, width: 300, height: 40))
    }

}

