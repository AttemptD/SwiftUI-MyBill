////
////  chartView.swift
////  MyBill
////
////  Created by Attempt D on 2020/9/11.
////  Copyright © 2020 Frank D. All rights reserved.
////
//
//import SwiftUI
//
//struct chartView: UIViewControllerRepresentable {
//    
//    @State var width:CGFloat
//    @State var height:CGFloat
//    @State var chartX : [String]
//    @ObservedObject var appData:AppData
//    @Environment(\.colorScheme) var colorScheme
//    func makeUIViewController(context: Context) -> UIViewController {
//        let uiViewController = UIViewController()
//        return uiViewController
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        var chartView: LineChartView!
//        
//        //创建折线图组件对象
//        chartView = LineChartView()
//        chartView.frame = CGRect(x: 0, y: 0, width: self.width,height: self.height)
//        chartView.legend.enabled = false
//        chartView.leftAxis.enabled = false
//        chartView.leftAxis.spaceTop = 0.4
//        chartView.leftAxis.spaceBottom = 0.4
//        chartView.rightAxis.spaceTop = 0.4
//        chartView.rightAxis.enabled = false
//        
//        chartView.xAxis.enabled = true
//        
//        
//        //折线图背景色
//        chartView.backgroundColor = colorScheme == .dark ? UIColor.init(named: "MainCellSpacerColor_dark") : .white
//        
//        //生成数据
//        var dataEntries = [ChartDataEntry]()
//        
//        var data = [Double]()
//        
//        data = self.appData.weekData
//        
//        for i in 0..<data.count {
//            let y = data[i]
//            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
//            dataEntries.append(entry)
//        }
//        
//        chartView.xAxis.labelPosition = .bottom
//        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: chartX)
//        chartView.xAxis.labelCount = 6
//        chartView.xAxis.labelTextColor = UIColor.black;
//        chartView.xAxis.labelFont = UIFont.systemFont(ofSize: 7.5);
//        chartView.xAxis.drawGridLinesEnabled = false
//        chartView.xAxis.forceLabelsEnabled = true
//        chartView.xAxis.granularityEnabled = true
//        
//        //这50条数据作为1根折线里的所有数据
//        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "")
//        chartDataSet.lineWidth = 2
//        chartDataSet.setColor(.orange)
//        chartDataSet.setCircleColor(.black)
//        chartDataSet.highlightEnabled = false
//        chartDataSet.drawValuesEnabled = true //绘制拐点上的文字
//        chartDataSet.drawCirclesEnabled = false //不绘制转折点
//        chartDataSet.mode = .horizontalBezier
//        
//        chartDataSet.drawFilledEnabled = true
//        //渐变颜色数组
//        let gradientColors = [UIColor.orange.cgColor, UIColor.orange.cgColor] as CFArray
//        //每组颜色所在位置（范围0~1)
//        let colorLocations:[CGFloat] = [1.0, 0.01]
//        //生成渐变色
//        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
//                                       colors: gradientColors, locations: colorLocations)
//        //将渐变色作为填充对象s
//        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
//        //目前折线图只包括1根折线
//        let chartData = LineChartData(dataSets: [chartDataSet])
//        
//        //设置折现图数据
//        chartView.data = chartData
//        
//        uiViewController.view.addSubview(chartView)
//        
//    }
//}
//
