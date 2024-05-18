import SwiftUI

struct PayCheck: View {
    @State private var username: String = "Pago recibido"
    @Binding var balance: String
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea() // Fondo blanco que ignora el Safe Area
            VStack {
                HStack {
                    Spacer() // Esto empujará el botón de ayuda hacia la derecha
                    Button(action: {
                        // Acción que se realizará cuando se presione el botón de duda
                    }) {
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                    }
                }
                .padding()
                
                ZStack {
                    Circle()
                        .strokeBorder(Color.red, lineWidth: 10) // Borde rojo del círculo
                        .frame(width: 200, height: 200) // Tamaño del círculo
                    Image(systemName: "checkmark") // Reemplaza con el nombre de tu imagen
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color.gray)
                }
                .padding(.top, 2) // Espacio desde el botón de ayuda
                
                Text("\(username)!")
                    .font(.system(size: 40))
                    .padding(.top, 9)
                    .bold()
                
                Text("$\(balance)")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .padding(.top, 0.0)
                
                Image("switch")
                    .resizable()
                    .frame(width: 200, height: 75)
                    .foregroundColor(.black)
                
                Spacer() // Empuja todo hacia arriba
            }
        }
    }
}
