//
//  CircularRuler.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/29/24.
//

import SwiftUI

struct FullCircle: Shape {
    var drawMarkers: Bool = false
    var lineWidth: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = rect.width / 2 - lineWidth / 2 // Adjust the radius to account for the stroke width
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: radius - lineWidth/2,
                    startAngle: .degrees(0),
                    endAngle: .degrees(360),
                    clockwise: false)
        
        if drawMarkers {
            let count = 240 // for 12 inches, each 0.1 inch is a marking but full circle now
            let angleDifference = CGFloat.pi * 2 / CGFloat(count)
            let bigMarkLength: CGFloat = lineWidth * 1 // Big marks
            let mediumMarkLength: CGFloat = lineWidth * 0.75 // Medium marks (every 0.5 inch)
            let smallMarkLength: CGFloat = lineWidth * 0.5 // Small marks (every 0.1 inch)
            
            for i in 0...count {
                let angle = angleDifference * CGFloat(i)
                let markLength = i % 10 == 0 ? bigMarkLength : (i % 5 == 0 ? mediumMarkLength : smallMarkLength)
                
                let innerRadius = radius - markLength
                let outerRadius = radius
                let xOuter = rect.midX + cos(angle) * outerRadius
                let yOuter = rect.midY + sin(angle) * outerRadius
                let xInner = rect.midX + cos(angle) * innerRadius
                let yInner = rect.midY + sin(angle) * innerRadius
                
                path.move(to: CGPoint(x: xInner, y: yInner))
                path.addLine(to: CGPoint(x: xOuter, y: yOuter))
            }
        }
        
        
        return path
    }
}

struct CircularRuler: View {
    @Binding var selectedMeasurement: MuscleMeasurement? // Track the current value
    @State var currentValue : Float = 0
    @State private var angle: CGFloat = 0 // Current rotation angle
    @State private var startDragAngle: CGFloat? = nil // Angle at the start of the drag
    @EnvironmentObject var measurementManager : MeasurementManager
    let maxValue: CGFloat = 100 // Maximum value in inches
    let lineWidth: CGFloat = 30
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack{
                    // Draw the main circle
                    FullCircle(lineWidth: lineWidth)
                        .stroke(Color.gray, lineWidth: lineWidth)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    // Draw full circle for markings but clip to show only top half
                    FullCircle(drawMarkers: true, lineWidth: lineWidth)
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .rotationEffect(.degrees(Double(-angle)), anchor: .center)
                        .sensoryFeedback(.selection, trigger: currentValue)
                }
                .clipShape(Rectangle().path(in: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height / 2))) // Clipping
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 2, height: lineWidth)
                    .offset(x: 0, y: -(geometry.size.width / 2 - lineWidth / 2) + lineWidth / 2)

                if let selectedMeasurement{
                    muscleItem(muscle: selectedMeasurement, value: currentValue)
                    .offset(x: 0,y: -(geometry.size.width/8))
                    .frame(width: 150)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.handleDragChange(gesture, in: geometry.size)
                    }
                    .onEnded { _ in
                        self.snapToNearestMarking()
                    }
            )
            .onAppear{
                if let selectedMeasurement{
                    currentValue = measurementManager.value(for: selectedMeasurement)
                    angle = CGFloat(currentValue*15)
                }
            }
            .onChange(of: selectedMeasurement) { oldValue, newValue in
                if let selectedMeasurement{
                    currentValue = measurementManager.value(for: selectedMeasurement)
                    angle = CGFloat(currentValue*15)
                }
            }
            
        }
    }

    private func handleDragChange(_ gesture: DragGesture.Value, in size: CGSize) {
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        let touchPoint = gesture.location
        let deltaX = touchPoint.x - center.x
        let deltaY = center.y - touchPoint.y
        let currentAngleInRadians = atan2(deltaY, deltaX)
        let currentAngleInDegrees = currentAngleInRadians * 180 / .pi

        if let startAngle = startDragAngle {
                var deltaAngle = currentAngleInDegrees - startAngle
                if deltaAngle > 180 {
                    deltaAngle -= 360
                } else if deltaAngle < -180 {
                    deltaAngle += 360
                }
                let newAngle = angle + deltaAngle
                let clampedAngle = max(0, min(newAngle, 1500)) // Clamp between 0 and 100
                if clampedAngle >= 0 && (clampedAngle) <= 1500 {
                    angle = clampedAngle
                    currentValue = Float(round(angle/15*10))/10.0 // Directly map angle to currentValue
                }
                
                startDragAngle = currentAngleInDegrees
            } else {
                startDragAngle = currentAngleInDegrees
            }
    }

    private func snapToNearestMarking() {
        let totalMarkings = 240 // Adjust if needed to fit the maximum 100 degrees
        let degreesPerMark = 360 / CGFloat(totalMarkings)
        let nearestMark = round(angle / degreesPerMark) * degreesPerMark
        let clampedNearestMark = max(0, min(nearestMark, 1500)) // Ensure it does not exceed 100 degrees
        angle = clampedNearestMark
        currentValue =  Float(round(angle/15*10))/10.0 // Adjust this conversion if needed
        startDragAngle = nil // Reset the start angle after snapping
        if let selectedMeasurement{
            measurementManager.measurements[selectedMeasurement] = currentValue
            measurementManager.saveMeasurements()
        }
    }

}

struct CircularRuler_Previews: PreviewProvider {
    static var previews: some View {
        CircularRuler(selectedMeasurement: .constant(.bicepsLeft))
            .environmentObject(MeasurementManager())
    }
}

