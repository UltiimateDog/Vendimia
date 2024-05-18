import SwiftUI
import LocalAuthentication
import PassKit

struct FindUser: View {
    var modelData: ModelData = .shared
    @State private var username: String = "Goben"
    @Binding var balance: String
    let dWidth: Double
    @State private var rotationAngle = 0.0
    let dHeight: Double
    let colorP = ColorPalette()
    
    @State private var showPayment = false
    @State private var authenticationSuccess = false
    @State private var unlocked = false
    @State private var isAuthenticated = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea() // Fondo blanco que ignora el Safe Area
            NavigationStack {
                HStack {
                    Spacer() // Esto empujará el botón de ayuda hacia la derecha
                    NavigationLink {
                        Q_A()
                    } label: {
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
                        .stroke(colorP.rojo, lineWidth: 15)
                        .frame(width: dWidth * 0.8)
                        .padding(.top, 20)
                    Circle()
                        .fill(colorP.gris)
                        .frame(width: dWidth * 0.8)
                        .overlay {
                            if modelData.identifiedPerson != "Goben Diego Constantino Aguirre" {
                                CameraView()
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "dollarsign.arrow.circlepath")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: dWidth*0.6)
                                    .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
                                    .foregroundStyle(Color.green)
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: false)) {
                                            rotationAngle += 360
                                        }
                                    }
                            }
                        }
                    .padding(.top, 20)
                } // Espacio desde el botón de ayuda

                    ZStack {
                        VStack {
                            HStack {
                                Text("Hola")
                                    .font(.title)
                                    .foregroundStyle(Color.black)
                                    .padding(.top, 8)
                                Text("\(username)!")
                                    .font(.title)
                                    .foregroundStyle(Color.black)
                                    .bold()
                                    .padding(.top, 8)
                            }
                            
                            Text("Estás por transferir...")
                                .font(.title2)
                                .italic()
                                .foregroundStyle(Color.black)
                                .padding(.top, 4)
                            
                            Text("$\(balance)")
                                .font(.system(size: 70))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.black)
                                .padding(.top, 3)
                            
                            Button {
                                modelData.identifiedPerson = "None"
                            } label: {
                                Text("Volver a escanear")
                                    .foregroundStyle(Color.black)
                                    .font(.largeTitle)
                            }
                        }
                        .offset(x: modelData.identifiedPerson != "Goben Diego Constantino Aguirre" ? 0 : -dWidth)
                        
                        VStack {
                            Text("Rostro valido")
                                .foregroundStyle(Color.green)
                                .font(.title2)
                                .bold()
                            HStack {
                                Spacer()
                                Button {
                                    modelData.identifiedPerson = "None"
                                } label: {
                                    Image(systemName: "xmark.seal.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: dWidth*0.15)
                                }
                                Spacer()
                                Button {
                                    showPayment = true
                                } label: {
                                    Image(systemName: "checkmark.seal.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(Color.green)
                                        .frame(width: dWidth*0.15)
                                }
                                Spacer()
                            }
                            .padding(.top, 10)
                        }
                        .offset(x: modelData.identifiedPerson == "Goben Diego Constantino Aguirre" ? 0 : dWidth)
                    }
                Spacer() // Empuja todo hacia arriba
            }
            .sheet(isPresented: $showPayment) {
                PayCheck(balance: $balance)
            }
        }
    }
    
    private func delayAction() async {
            // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
            try? await Task.sleep(nanoseconds: 100_000_000)
        }
}
