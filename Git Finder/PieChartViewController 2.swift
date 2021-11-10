//
//  PieChartViewController.swift
//  Git Finder
//
//  Created by Asif Rabbi on 20/9/21.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {
    
    var pieChartView: PieChartView = PieChartView()
    var pieChart = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 8.8]

        pieChart.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        pieChart.center = view.center
        pieChart.backgroundColor = #colorLiteral(red: 0.4115059078, green: 0.4115797281, blue: 0.411496222, alpha: 0)
        self.view.addSubview(pieChart)
        
        pieChartView = PieChartView(frame: pieChart.bounds)
//        self.view.addSubview(pieChartView!)
        pieChart.addSubview(pieChartView)
        
        setChart(dataPoints: months, values: unitsSold)

    }

    func setChart(dataPoints: [String], values: [Double]) {

        var dataEntries: [ChartDataEntry] = []

        for i in 0..<values.count {
            let dataEntry1 = PieChartDataEntry(value: values[i])
            dataEntries.append(dataEntry1)
        }

        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setValueTextColor(NSUIColor.clear) // Hides data value
        pieChartView.data = pieChartData
        
        let colors: [UIColor] = [.red, .orange, .blue, .green, .yellow, .black, .brown, .cyan, .darkGray]
        pieChartDataSet.colors = colors
        
        pieChartDataSet.selectionShift = 0 // Hides the tap facilities and goes full view
        pieChartView.transparentCircleColor = UIColor.clear // hides the inner circle
        
//        pieChartView.frame.size = CGSize(width: 80, height: pieChart.frame.size.height)
        pieChartView.holeRadiusPercent = 0.8 // Changes slices width
    }
 }
