//
//  LineChartView.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import CoreGraphics
@objc(BarChartFormatter)
public class BarChartFormatter: NSObject, IAxisValueFormatter{
    
    open var labels: [String]!
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        return labels[Int(value)]
    }
}
@objc(YAxisValueFormatter)
public class YAxisValueFormatter: NSObject, IAxisValueFormatter {
    
    let numFormatter: NumberFormatter
    
    override init() {
        numFormatter = NumberFormatter()
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 0
        
        // if number is less than 1 add 0 before decimal
        numFormatter.minimumIntegerDigits = 1 // how many digits do want before decimal
        numFormatter.paddingPosition = .beforePrefix
        numFormatter.paddingCharacter = "0"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return numFormatter.string(from: NSNumber(floatLiteral: value))!
    }
}

@objc(ValueFormatter)
public class ValueFormatter: NSObject, IValueFormatter {
    let numFormatter: NumberFormatter
    
    override init() {
        numFormatter = NumberFormatter()
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 0
        
        // if number is less than 1 add 0 before decimal
        numFormatter.minimumIntegerDigits = 1 // how many digits do want before decimal
        numFormatter.paddingPosition = .beforePrefix
        numFormatter.paddingCharacter = "0"
    }
    
    public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return numFormatter.string(from: NSNumber(floatLiteral: value))!
    }
}

/// Chart that draws lines, surfaces, circles, ...
open class LineChartView: BarLineChartViewBase, LineChartDataProvider
{
    internal override func initialize()
    {
        super.initialize()
        
        renderer = LineChartRenderer(dataProvider: self, animator: _animator, viewPortHandler: _viewPortHandler)
    }
    
    // MARK: - LineChartDataProvider
    
    open var lineData: LineChartData? { return _data as? LineChartData }
    @objc open var lineChartData: LineChartData?
    open var lineChartMinXRange: Double = 0.0
    
    open var lineChartMaxXRange: Double = 0.0

    @objc open func setData() {
        self.data = self.lineChartData
    }
    @objc open func setXRange() {
        self.setVisibleXRange(minXRange: self.lineChartMinXRange, maxXRange: self.lineChartMaxXRange)
    }
    @objc open func setScaleEnable() {
        self.setScaleEnabled(false)
    }
}
