//
//  ViewController.swift
//  image painter
//
//  Created by user on 2017/6/29.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var btnProp = false
    
    
    @IBOutlet weak var painter: paintUIV!
    
    @IBOutlet weak var drawStroke: UIStackView!
    
    @IBAction func stroke(_ sender: Any) {
        painter.changeType(0)
    }
    
    @IBAction func rectstroke(_ sender: Any) {
        painter.changeType(2)
    }
    
    @IBAction func tristroke(_ sender: Any) {
        painter.changeType(3)
    }
    
    
    @IBAction func clickstroke(_ sender: Any) {
        drawStroke.isHidden = btnProp
        btnProp = !btnProp
    }
    
    
    
    @IBAction func clear(_ sender: Any) {
        painter.clear()
    }
    
    @IBAction func updo(_ sender: Any) {
        painter.updo()
    }
    
    
    @IBAction func redo(_ sender: Any) {
        painter.redo()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawStroke.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

