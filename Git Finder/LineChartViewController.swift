//
//  LineChartViewController.swift
//  Git Finder
//
//  Created by Asif Rabbi on 15/9/21.
//

import UIKit
import Charts
import TinyConstraints

class LineChartViewController: UIViewController, ChartViewDelegate {
    
    class func initVC()->UIViewController {
        let board = UIStoryboard.init(name: "Landing", bundle: nil)
        return board.instantiateViewController(withIdentifier: "LineChartViewController")
    }
    var yAxiss : YAxisRenderer?
    
    lazy var lineChartView:LineChartView = {
        let lineChart = LineChartView()
        lineChart.backgroundColor = #colorLiteral(red: 0.05126982182, green: 0.12172658, blue: 0.1982372999, alpha: 1)
        lineChart.rightAxis.enabled = false
        lineChart.pinchZoomEnabled = false
        lineChart.doubleTapToZoomEnabled = false
        
        // yAxis - Left
        let yAxis = lineChart.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(5, force: false)
        yAxis.labelTextColor = .darkGray
        yAxis.axisLineColor = .darkGray
        yAxis.gridLineWidth.round()
        yAxis.drawGridLinesEnabled = false
        
        // xAxis - Bottom
        let xAxis = lineChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.setLabelCount(5, force: false)
        xAxis.labelTextColor = .darkGray
        xAxis.axisLineColor = .darkGray
        lineChart.leftAxis.axisLineDashPhase = .nan
        
        lineChart.animate(xAxisDuration: 1.5)
        lineChart.moveViewToY(0.0, axis: yAxis.axisDependency)
        
        return lineChart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        
        let marker = BalloonMarker(color: #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 0.873382776),
                                           font: .systemFont(ofSize: 12),
                                           textColor: .white,
                                           insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
                marker.chartView = lineChartView
                marker.minimumSize = CGSize(width: 40, height: 40)
                lineChartView.marker = marker
        
        setup()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setup() {
        
        let set1 = LineChartDataSet(entries: yValues, label: "Subscribers")
        set1.drawCirclesEnabled = false //hides the peek circles
        set1.mode = .cubicBezier
        set1.lineWidth = 4
        set1.setColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.drawVerticalHighlightIndicatorEnabled = false
        set1.drawValuesEnabled = true
        set1.valueTextColor = .systemGray
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)//hides the peek circle values
        
        lineChartView.data = data
    }
    
    let yValues :[ChartDataEntry] = [
        ChartDataEntry(x: 0.1, y: 5),
        ChartDataEntry(x: 0.5, y: 1),
        ChartDataEntry(x: 1.0, y: 10),
        ChartDataEntry(x: 1.5, y: 2.5),
        ChartDataEntry(x: 2.0, y: 12),
        ChartDataEntry(x: 2.5, y: 16),
        ChartDataEntry(x: 3.0, y: 4.0),
        ChartDataEntry(x: 3.5, y: 4.5),
        ChartDataEntry(x: 4.0, y: 5.0),
        ChartDataEntry(x: 4.5, y: 12),
        ChartDataEntry(x: 5.0, y: 6.0),
        ChartDataEntry(x: 5.5, y: 6.5),
        ChartDataEntry(x: 6.0, y: 1),
        ChartDataEntry(x: 0.1, y: 5),
        ChartDataEntry(x: 0.5, y: 1),
        ChartDataEntry(x: 1.0, y: 10),
        ChartDataEntry(x: 1.5, y: 2.5),
        ChartDataEntry(x: 2.0, y: 12),
        ChartDataEntry(x: 2.5, y: 16),
        ChartDataEntry(x: 3.0, y: 4.0),
        ChartDataEntry(x: 3.5, y: 4.5),
        ChartDataEntry(x: 4.0, y: 5.0),
        ChartDataEntry(x: 4.5, y: 12),
        ChartDataEntry(x: 5.0, y: 6.0),
        ChartDataEntry(x: 5.5, y: 6.5),
        ChartDataEntry(x: 6.0, y: 1),
        ChartDataEntry(x: 0.1, y: 5),
        ChartDataEntry(x: 0.5, y: 1),
        ChartDataEntry(x: 1.0, y: 10),
        ChartDataEntry(x: 1.5, y: 2.5),
        ChartDataEntry(x: 2.0, y: 12),
        ChartDataEntry(x: 2.5, y: 16),
        ChartDataEntry(x: 3.0, y: 4.0),
        ChartDataEntry(x: 3.5, y: 4.5),
        ChartDataEntry(x: 4.0, y: 5.0),
        ChartDataEntry(x: 4.5, y: 12),
        ChartDataEntry(x: 5.0, y: 6.0),
        ChartDataEntry(x: 5.5, y: 6.5),
        ChartDataEntry(x: 6.0, y: 1),
        ChartDataEntry(x: 0.1, y: 5),
        ChartDataEntry(x: 0.5, y: 1),
        ChartDataEntry(x: 1.0, y: 10),
        ChartDataEntry(x: 1.5, y: 2.5),
        ChartDataEntry(x: 2.0, y: 12),
        ChartDataEntry(x: 2.5, y: 16),
        ChartDataEntry(x: 3.0, y: 4.0),
        ChartDataEntry(x: 3.5, y: 4.5),
        ChartDataEntry(x: 4.0, y: 5.0),
        ChartDataEntry(x: 4.5, y: 12),
        ChartDataEntry(x: 5.0, y: 6.0),
        ChartDataEntry(x: 5.5, y: 6.5),
        ChartDataEntry(x: 6.0, y: 1)
    ]
    
}

