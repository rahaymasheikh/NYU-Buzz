//
//  AddEventViewController.swift
//  NYU_Buzz_Mockup
//
//  Created by Rahayma Sheikh on 5/3/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

// UIViewController code adapted from tutorial found on: codewithchris.com/uipickerview-example/

import UIKit

class DatePicker: UIDatePicker{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        setValue(false, forKey: "highlightsToday")
        setValue(UIColor.white, forKey: "textColor")
    }
}

class AddEventViewController: UIViewController, UIPickerViewDelegate,
UIPickerViewDataSource {

    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var categoryPickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Connect the data:
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        // Add categorical data to array:
        categoryPickerData = ["Wellness", "Cultural", "Religious", "Academic",
                              "Athletic", "Food", "Entertainment", "Career",
                              "Other"]
        self.categoryPicker.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        self.categoryPicker.setValue(false, forKeyPath: "highlightsToday")
        self.categoryPicker.setValue(UIColor.white, forKeyPath: "textColor")

    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return categoryPickerData.count
    }
    
    // Data for row and column that's being passed in
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: categoryPickerData[row],
                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


