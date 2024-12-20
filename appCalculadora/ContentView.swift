//
//  ContentView.swift
//  appCalculadora
//
//  Created by Guest User on 09/12/24.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case sum = "+"
    case multp = "*"
    case div = "/"
    case res = "-"
    case equal = "="
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    case clear = "AC"
    
    var buttonColor: Color {
        switch self {
        case .sum, .res, .multp, .div, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, sub, multp, div, none
}

struct ContentView: View {
    
    @State var runningNumber = 0
    @State var value = "0"
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .div],
        [.seven, .eight, .nine, .multp],
        [.four, .five, .six, .res],
        [.one, .two, .three, .sum],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        HStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Spacer()
                        Text(value)
                            .bold()
                            .font(.system(size: 100))
                            .foregroundColor(.black)
                    }
                    VStack {
                        ForEach(buttons, id: \.self) { row in
                            HStack(spacing: 10) {
                                ForEach(row, id: \.self) { item in
                                    Button(action: {
                                        self.didTap(button: item)
                                    }, label: {
                                        Text(item.rawValue)
                                            .font(.system(size: 32))
                                            .frame(width: self.buttonWidth(item: item), height: 100)
                                            .foregroundColor(.black)
                                            .background(item.buttonColor)
                                            .cornerRadius(26)
                                    })
                                }
                            }
                            .padding(.bottom, 1)
                        }
                    }
                }
            }
        }
    }
    
    func buttonHeight() -> CGFloat {
        return ((UIScreen.main.bounds.width - (4 * 12)))
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        
        return ((UIScreen.main.bounds.width - (5 * 12)) / 4)
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .sum, .res, .multp, .div, .equal:
            if button == .sum {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .res {
                self.currentOperation = .sub
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .multp {
                self.currentOperation = .multp
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .div {
                self.currentOperation = .div
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningValue + currentValue)"
                case .sub:
                    self.value = "\(runningValue - currentValue)"
                case .multp:
                    self.value = "\(runningValue * currentValue)"
                case .div:
                    if currentValue != 0 {
                        self.value = "\(runningValue / currentValue)"
                    } else {
                        self.value = "Error"
                    }
                case .none:
                    break
                }
            }
            
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal:
            if !self.value.contains(".") {
                self.value += "."
            }
        case .negative:
            if let currentValue = Double(self.value) {
                self.value = "\(currentValue * -1)"
            }
        case .percent:
            if let currentValue = Double(self.value) {
                self.value = "\(currentValue / 100)"
            }
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    // Función para verificar si un número es primo
    func isPrime(_ number: Int) -> Bool {
        guard number > 1 else { return false }
        for i in 2..<number {
            if number % i == 0 {
                return false
            }
        }
        return true
    }
}

// Vista previa
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
