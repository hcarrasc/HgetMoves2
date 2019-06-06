//
//  GraphView.swift
//  HgetMoves2
//
//  Created by Hector on 6/6/19.
//  Copyright © 2019 hcarrasco. All rights reserved.
//

import Cocoa

class GraphView: NSView {
    
    struct Wrapper {
        var width: CGFloat
        var height: CGFloat
        var linesColor: NSColor
    }

    override func draw(_ dirtyRect: NSRect) {
        
        // prepare bezier
        let wrapper = Wrapper(width: dirtyRect.width, height: dirtyRect.height, linesColor: NSColor.white)
        wrapper.linesColor.set()
        let figure = NSBezierPath()
        
        // dibujar ejex
        figure.move(to: NSMakePoint(20, 20)) // start point
        figure.line(to: NSMakePoint(20, wrapper.height))
        // flecha
        figure.move(to: NSMakePoint(20, wrapper.height)) // start point
        figure.line(to: NSMakePoint(20-6, wrapper.height-6))// destination
        figure.move(to: NSMakePoint(20, wrapper.height)) // start point
        figure.line(to: NSMakePoint(20+6, wrapper.height-6))// destination
        
        // dibujar ejey
        figure.move(to: NSMakePoint(20, 20))
        figure.line(to: NSMakePoint(wrapper.width-20, 20))
        // flecha
        figure.move(to: NSMakePoint(wrapper.width-20, 20))
        figure.line(to: NSMakePoint(wrapper.width-28, 12))
        figure.move(to: NSMakePoint(wrapper.width-20, 20))
        figure.line(to: NSMakePoint(wrapper.width-28, 28))
        
        // dibujar puntos
        let center = CGPoint(x: 30.0, y: 150.0)
        figure.move(to: center)
        figure.line(to: CGPoint(x: center.x, y: center.y))
        figure.appendArc(withCenter: center, radius: 2, startAngle: 2, endAngle: 2)
        
        figure.lineWidth = 1.3  // hair line
        figure.stroke()
        
    }
    
}
