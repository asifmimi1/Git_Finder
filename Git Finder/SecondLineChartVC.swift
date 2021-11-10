//
//  SecondLineChartVC.swift
//  Git Finder
//
//  Created by Asif Rabbi on 10/11/21.
//

import UIKit
import Charts

class SecondLineChartVC: UIViewController, ChartViewDelegate {
    
    class func initVC()->UIViewController {
        let board = UIStoryboard.init(name: "Landing", bundle: nil)
        return board.instantiateViewController(withIdentifier: "SecondLineChartVC")
    }
    
    lazy var lineChartView:LineChartView = {
        let lineChart = LineChartView()
        lineChart.backgroundColor = #colorLiteral(red: 0.05126982182, green: 0.12172658, blue: 0.1982372999, alpha: 1)
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.enabled = false
        lineChart.legend.enabled = false
        lineChart.xAxis.enabled = false
        lineChart.pinchZoomEnabled = false
        lineChart.leftAxis.axisLineDashPhase = .nan
        
        return lineChart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        
        setup()
    }
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setup() {
        
        let set1 = LineChartDataSet(entries: yValues, label: "")
        set1.drawCirclesEnabled = false //hides the peek circles
        set1.mode = .cubicBezier
        set1.lineWidth = 0
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.drawVerticalHighlightIndicatorEnabled = false

        set1.fillAlpha = 1
        set1.fillColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        set1.drawFilledEnabled = true
        
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
