import SwiftUI

struct UserNameView: View {
    @Binding var goTo: Bool
    @Binding var value: String
    @State var name = ""
    @State var password = ""
    @State private var iconName = "checkmark.circle"
    @State private var rotationAngle = 0.0
    let colorP = ColorPalette()
    let dWidth: Double
    let dHeight: Double
    
    var body: some View {
        if !goTo  {
            ZStack {
                Rectangle()
                    .fill(Color(red: 57/255, green: 57/255, blue: 57/255))
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("¿Quién eres?")
                        .font(.system(size: 45))
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                        .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                    
                    TextField("Nombre completo", text: $name)
                        .font(.system(size: 35))
                        .frame(width: 350, height: 55)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(colorP.gris)
                        )
                    
                    SecureField("Palabra secreta", text: $password)
                        .font(.system(size: 35))
                        .frame(width: 350, height: 55)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(colorP.gris)
                        )
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            rotationAngle += 180
                            iconName = iconName == "checkmark.circle" ? (name == "Goben Diego Constantino Aguirre" && password == "hack" ? "checkerboard.shield" : "xmark.seal.fill" ) : "checkmark.circle"
                            Task {
                                await delayAction()
                            }
                        }
                    }) {
                        Image(systemName: iconName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
                            .foregroundStyle(name == "Goben Diego Constantino Aguirre" && password == "hack" ? Color.green : Color.red)
                    }
                    .padding(.top,30)
                }
                .ignoresSafeArea()
            }
        } else {
            FindUser(balance: $value, dWidth: dWidth, dHeight: dHeight)
        }
    }
    
    private func delayAction() async {
        // Delay of 1 second
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        withAnimation {
            rotationAngle += 180
            iconName = iconName == "checkmark.circle" ? (name == "Goben Diego Constantino Aguirre" && password == "hack" ? "checkerboard.shield" : "xmark.seal.fill" ) : "checkmark.circle"
            if name == "Goben Diego Constantino Aguirre" && password == "hack" {
                goTo = true
            }
        }
    }
}

