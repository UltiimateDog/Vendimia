import SwiftUI

enum Numbers: String {
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
    case cancel = "multiply"
    case delete = "delete.backward"
    case check = "checkmark"
}

// Vista principal donde están los botones y la lógica asociada
struct TopView: View {
    @State var goTo = false // Debe ser false
    @State var value = "0.00"
    @State private var showingSheet = false
    let colorP = ColorPalette()

    let buttons: [[Numbers]] = [
        [.one, .two, .three],
        [.four, .five, .six],
        [.seven, .eight, .nine],
        [.zero],
        [.cancel, .delete, .check]
    ]
    
    let dwidth: Double
    let dHeight: Double
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                NavigationLink {
                    Q_A()
                } label: {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                }
                .padding(.trailing, 20) //Padding del botón
            }
            .padding(.top, 5)
            
            HStack {
                Text("$")
                    .font(.system(size: 80))
                    .fontWeight(.bold)
                    .foregroundStyle(colorP.rojo)
                    .padding(.top, 40)
                Text(value)
                    .font(.system(size: 80))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                    .padding(.top, 40)
            }
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .fill(Color(red: 57/255, green: 57/255, blue: 57/255))
                    .frame(height: dHeight * 0.7)
                    .padding(.bottom, 10)
                
                VStack(spacing: 20) {
                    ForEach(buttons.indices, id: \.self) { rowIndex in
                        HStack(spacing: 10) {
                            ForEach(buttons[rowIndex], id: \.self) { item in
                                Button(action: {
                                    didTap(button: item)
                                }) {
                                    if rowIndex == buttons.count - 1 {
                                        Image(systemName: item.rawValue)
                                            .font(.system(size: 45))
                                            .foregroundColor(.white)
                                            .frame(width: 115, height: 70)
                                            .background(actionButtonColor(item: item))
                                            .cornerRadius(20)
                                    } else {
                                        Text(item.rawValue)
                                            .font(.system(size: 45))
                                            .fontWeight(.bold)
                                            .frame(width: dwidth * 0.28, height: dwidth * 0.16)
                                            .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                                            .foregroundColor(Color(red: 57/255, green: 57/255, blue: 57/255))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, dHeight * 0.08)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: $showingSheet) {
            withAnimation {
                UserNameView(goTo: $goTo, value: $value, dWidth: dwidth, dHeight: dHeight)
                    .presentationDetents([.height(goTo ? dHeight : dHeight * 0.75)]) //Altura máxima del UserNameView
            }
        }
    }
    func didTap(button: Numbers) {
        switch button {
        case .cancel:
            value = "0.00"  // Restablece a cero completo.
        case .delete:
            // Gestiona la eliminación asegurando que los decimales siguen siendo dos.
            if value != "0.00" {
                let numericValue = Double(value) ?? 0.00
                let truncatedValue = floor(numericValue * 10) / 100  // Trunca un decimal.
                value = String(format: "%.2f", truncatedValue)
            } else {
                value = "0.00"
            }
        case .check:
                showingSheet = true
            break
        default:
            let number = button.rawValue
            if value == "0.00" {
                value = "0.0" + number  // Comienza con el nuevo número en la posición de centavos.
            } else {
                // Añade un nuevo número desplazando el actual a la izquierda.
                let numericValue = Double(value.replacingOccurrences(of: ",", with: ".")) ?? 0.00
                let newValue = (numericValue * 10) + (Double(number) ?? 0) / 100
                value = String(format: "%.2f", newValue)
            }
        }
    }

    func actionButtonColor(item: Numbers) -> Color {
        switch item {
        case .cancel:
            return Color.red
        case .delete:
            return Color.yellow
        case .check:
            return Color.green
        default:
            return Color.gray
        }
    }
}
struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView(dwidth: 300, dHeight: 700)
    }
}
