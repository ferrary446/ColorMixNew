//
//  ViewController.swift
//  ColorMixNew
//
//  Created by Ilya Yushkov on 11.06.2021.
//

import UIKit

class RGBViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueOutlet: UILabel!
    @IBOutlet var greenValueOutlet: UILabel!
    @IBOutlet var blueValueOutlet: UILabel!
    
    @IBOutlet var redSliderOutlet: UISlider!
    @IBOutlet var greenSliderOutlet: UISlider!
    @IBOutlet var blueSliderOutlet: UISlider!
    
    @IBOutlet var redTextFieldOutlet: UITextField!
    @IBOutlet var greenTextFieldOutlet: UITextField!
    @IBOutlet var blueTextFieldOutlet: UITextField!
    
    private var red: CGFloat = 0.0
    private var green: CGFloat = 0.0
    private var blue: CGFloat = 0.0
    
    var delegate: RGBViewControllerDelegate!
    var viewColor: UIColor!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        colorView.backgroundColor = viewColor
        customTextFields()
        customSliders()
        customView()
        
    }
    
    @IBAction func sliderAction() {
        
        red = CGFloat(redSliderOutlet.value)
        green = CGFloat(greenSliderOutlet.value)
        blue = CGFloat(blueSliderOutlet.value)
        
        redValueOutlet.text = String(format: "%.2f", red)
        greenValueOutlet.text = String(format: "%.2f", green)
        blueValueOutlet.text = String(format: "%.2f", blue)
        
        redTextFieldOutlet.text = String(format: "%.2f", red)
        greenTextFieldOutlet.text = String(format: "%.2f", green)
        blueTextFieldOutlet.text = String(format: "%.2f", blue)
        
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
}

extension RGBViewController: UITextFieldDelegate {
     
    private func setColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSliderOutlet.value),
                                            green: CGFloat(greenSliderOutlet.value),
                                            blue: CGFloat(blueSliderOutlet.value),
                                            alpha: 1.0)
    }
    
    private func customTextFields() {
        
        redTextFieldOutlet.delegate = self
        greenTextFieldOutlet.delegate = self
        blueTextFieldOutlet.delegate = self
        
        redTextFieldOutlet.text = "0.00"
        greenTextFieldOutlet.text = "0.00"
        blueTextFieldOutlet.text = "0.00"
        
        self.redTextFieldOutlet.keyboardType = UIKeyboardType.decimalPad
        self.greenTextFieldOutlet.keyboardType = UIKeyboardType.decimalPad
        self.blueTextFieldOutlet.keyboardType = UIKeyboardType.decimalPad
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            switch textField {
            case redTextFieldOutlet:
                redTextFieldOutlet.addDoneButtonOnKeyboard()
            case greenTextFieldOutlet:
                greenTextFieldOutlet.addDoneButtonOnKeyboard()
            default:
                blueTextFieldOutlet.addDoneButtonOnKeyboard()
            }
            
            guard let text = textField.text else { return }
            
            if let currentValue = Float(text) {
                switch textField {
                case redTextFieldOutlet:
                    redSliderOutlet.value = currentValue
                    redValueOutlet.text = String(format: "%.2f", currentValue)
                case greenTextFieldOutlet:
                    greenSliderOutlet.value = currentValue
                    greenValueOutlet.text = String(format: "%.2f", currentValue)
                default:
                    blueSliderOutlet.value = currentValue
                    blueValueOutlet.text = String(format: "%.2f", currentValue)
                }
                
                setColor()
                return
            }
            
            
        }
        
        textFieldDidEndEditing(redTextFieldOutlet)
        textFieldDidEndEditing(greenTextFieldOutlet)
        textFieldDidEndEditing(blueTextFieldOutlet)
        
    }
    
    private func customSliders() {
        
        redSliderOutlet.minimumTrackTintColor = .systemRed
        greenSliderOutlet.minimumTrackTintColor = .systemGreen
        blueSliderOutlet.minimumTrackTintColor = .systemBlue
        
        redSliderOutlet.maximumTrackTintColor = .white
        greenSliderOutlet.maximumTrackTintColor = .white
        blueSliderOutlet.maximumTrackTintColor = .white
        
    }
    
    private func customView() {
        
        colorView.layer.borderWidth = 2
        colorView.layer.cornerRadius = 10
        colorView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
}

extension UITextField {
    
    func addDoneButtonOnKeyboard() {
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self, action: #selector(resignFirstResponder))
        keyboardToolbar.items = [flexibleSpace, doneButton]
        self.inputAccessoryView = keyboardToolbar
        
    }
    
}
