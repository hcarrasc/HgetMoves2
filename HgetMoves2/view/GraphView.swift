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
    
    override func updateLayer() {
        self.layer?.backgroundColor = NSColor(named: "customControlColor")?.cgColor
    }

    override func draw(_ dirtyRect: NSRect) {
        
        updateLayer()
        
        let wrapper = Wrapper(width: dirtyRect.width, height: dirtyRect.height, linesColor: NSColor.white)
        wrapper.linesColor.set()
        let figure = NSBezierPath()
        
        
        // dibujar ejey
        figure.move(to: NSMakePoint(20, 20)) // start point
        figure.line(to: NSMakePoint(20, wrapper.height-10))
        // flecha
        figure.move(to: NSMakePoint(20, wrapper.height-10)) // start point
        figure.line(to: NSMakePoint(20-6, wrapper.height-16))// destination
        figure.move(to: NSMakePoint(20, wrapper.height-10)) // start point
        figure.line(to: NSMakePoint(20+6, wrapper.height-16))// destination
        
        // dibujar ejex
        figure.move(to: NSMakePoint(20, 20))
        figure.line(to: NSMakePoint(wrapper.width-20, 20))
        // flecha
        figure.move(to: NSMakePoint(wrapper.width-20, 20))
        figure.line(to: NSMakePoint(wrapper.width-28, 14))
        figure.move(to: NSMakePoint(wrapper.width-20, 20))
        figure.line(to: NSMakePoint(wrapper.width-28, 26))
        
        figure.lineWidth = 1.3  // hair line
        figure.stroke()
        
        // dibujar puntos
        let size = NSSize(width: 3, height: 3)
        let origins = [
                         NSPoint(x: 30, y: 150),
                         NSPoint(x: 50, y: 140),
                         NSPoint(x: 80, y: 170)
                      ]
        
        for origin in origins {
            let quad = NSBezierPath(roundedRect: NSRect(origin: origin, size: size), xRadius: 2, yRadius: 2)
            quad.fill()
            quad.stroke()
        }
        
    }

    
}
