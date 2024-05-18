import SwiftUI
import PhotosUI

struct ProfileView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    var modelData: ModelData = .shared
    let dWidth: Double
    let dHeight: Double
    let colorP = ColorPalette()
    
    @State private var anim = false
    @State private var showFull = false
    @State var wish = false
    @State var changePic = false
    @State var cardSelection = UserDefaults.standard.string(forKey: "SelectedCard") ?? "Banamex"
    @State private var avatarItem: PhotosPickerItem?
    @State private var showAddNewCardSheet = false
    
    @State private var Card_name : String = ""
    @State private var Card_num: String = ""
    @State private var Expiration_date: String = ""
    @State private var CVV : String = ""
    

    @State var cards = ["Banamex", "Master Card", "Visa", "Añadir Tarjeta..."]
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                profilePic()
                nameAShare()
                    .blur(radius: changePic ? 2 : 0)
                VStack {
                    Balance()
                        .offset(y : 0)
                    SelectCard()
                        .offset(y : -dHeight*0.22)
                    HStack {
                        ProgressContainer()
                            .cornerRadius(15)
                            .frame(width: dWidth*0.4, height: dWidth*0.4)
                            .border(colorP.rojo , width: 0)
                            .padding(7)
                            .background(colorP.rojo)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(colorP.rojo, lineWidth: 0)
                            )
                        ProgressContainer2()
                            .cornerRadius(15)
                            .frame(width: dWidth*0.4, height: dWidth*0.4)
                            .border(colorP.rojo , width: 0)
                            .padding(7)
                            .background(colorP.rojo)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(colorP.rojo, lineWidth: 0)
                            )
                    }
                    .offset(y : -dHeight*0.23)
                }
                .frame(width: dWidth , height: dHeight*0.6)
                .background(colorP.grisOscuro)
                .cornerRadius(15)
            }
            .padding(safeAreaInsets)
            .padding(.bottom, dWidth / 5 + 10)
        }
        .onAppear {
            changePic = false
        }
        
    }
    func chooseCard() -> some View {
        Menu(cardSelection) {
            ForEach(cards, id: \.self) { card in
                Button(action: {
                    if card == "Añadir Tarjeta..." {
                        showAddNewCardSheet = true
                    } else {
                        cardSelection = card
                        UserDefaults.standard.set(card, forKey: "SelectedCard")
                    }
                }) {
                    Text(card)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    func profilePic() -> some View {
        ZStack {
            Circle()
                .frame(width: dWidth * 0.45)
                .onAppear {
                    withAnimation() {
                        anim.toggle()
                    }
                }
            Image("appLogo")
                .resizable()
                .scaledToFit()
                .frame(width: dWidth * 0.59)
                .offset(x: -1)
                .rotationEffect(.degrees(anim ? 45 : 0))
                .scaleEffect(x: anim ? 1 : 0.99, y: anim ? 1 : 0.99)
                .blur(radius: changePic ? 2 : 0)
            Image(uiImage: modelData.profile.profilePic)
                .resizable()
                .scaledToFill()
                .frame(width: dWidth * 0.45, height: dWidth * 0.45)
                .background()
                .clipShape(Circle())
                .scaleEffect(x: changePic ? 1.1 : 1, y: changePic ? 1.1 : 1)
                .onLongPressGesture(minimumDuration: 0.5) {
                    withAnimation() {
                        changePic = true
                    }
                } onPressingChanged: { a in
                    withAnimation() {
                        changePic = a
                    }
                }
                
        }
        .popover(isPresented: $changePic) {
            HStack {
                Spacer()
                PhotosPicker("Cambiar foto de perfil", selection: $avatarItem, matching: .images)
                    .presentationCompactAdaptation(.popover)
                Spacer()
            }
            .presentationCompactAdaptation(.popover)
            .onChange(of: avatarItem) {
                        Task {
                            if let loaded = try? await avatarItem?.loadTransferable(type: Data.self) {
                                modelData.profile.profilePic = UIImage(data: loaded) ?? modelData.profile.profilePic
                            } else {
                                print("Failed")
                            }
                        }
                    }
        }
    }
    
    func nameAShare() -> some View {
        HStack {
            Text(modelData.profile.username)
                .font(.title)
                .bold()
                .foregroundStyle(Color.black)
                .offset(y: -dWidth * 0.02)
            Button {
                
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .scaledToFit()
                    .frame(width: dWidth*0.05)
                    .foregroundStyle(colorP.rojo)
                    .offset(y: -dWidth * 0.025)
            }
        }
    }
}

struct CircularProgressView: View {
    let progress: Double
    let colorP = ColorPalette()

    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color(colorP.gris).opacity(0.5),
                    lineWidth: 20
                )
                .frame(width: 90, height: 90)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color(colorP.barraBlanco),
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .frame(width: 90, height: 90)
            

            Text(String(format: "%.0f%%", progress * 100))
                .font(.headline)
                .foregroundColor(Color.white)
        }

    }
}


struct ProgressContainer: View {
    let colorP = ColorPalette()
    var body: some View {
        ZStack {
            Color(colorP.grisOscuro)
                .edgesIgnoringSafeArea(.all)

            VStack() {
                Spacer()
                HStack{
                    Text("Muy bien!")
                    Spacer()
                    
                }
                .padding(.horizontal)
                
                    .font(.system(size: 20, design: .rounded))
                    .foregroundColor(colorP.barraBlanco)
                Spacer()
                Spacer()
                HStack{
                    
                    Spacer()
                    CircularProgressView(progress: 0.6)
                        .padding(.horizontal)
                }
                Spacer()
                Spacer()
            }
        }
        
    }
}

struct ProgressContainer2: View {
    let colorP = ColorPalette()
    var body: some View {
        ZStack {
            Color(colorP.grisOscuro) // Agregar fondo blanco
                .edgesIgnoringSafeArea(.all) // Ignorar el área segura para cubrir todo el espacio

            VStack() {
                Spacer()
                HStack{
                    Text("Sigue asi!")
                    Spacer()
                    
                }
                .padding(.horizontal)
                
                    .font(.system(size: 20, design: .rounded))
                    .foregroundColor(colorP.barraBlanco)
                Spacer()
                Spacer()
                HStack{
                    
                    Spacer()
                    CircularProgressView(progress: 0.34)
                        .padding(.horizontal)
                }
                Spacer()
                Spacer()
            }
        }
        
    }
}

struct Balance: View {
    let colorP = ColorPalette()
    
    var body: some View {
        ZStack {
            // First, overlay the content on top
            colorP.rojo // Use the background color directly as the ZStack's background
                .frame(maxWidth: .infinity)
                .frame(height: 80) // Increase the height of the background
                .cornerRadius(15)
                .padding(20) // Apply padding directly to the background
            
            HStack {
                Spacer()
                Text("Saldo:")
                    .font(.system(size: 30, weight: .heavy, design: .rounded))
                    .foregroundColor(colorP.barraBlanco)
                Spacer()
                Text("$45,000")
                    .font(.system(size: 30, design: .rounded))
                    .foregroundColor(colorP.barraBlanco)
                Spacer()
            }
            
            // Then, place the background image
            Image("tierra")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.2) // Adjust opacity if needed
                .offset(x: 140, y: -20)
        }
    }
}
struct SelectCard: View {
    let colorP = ColorPalette()
    @State var cardSelection = UserDefaults.standard.string(forKey: "Seleccionar Tarjeta") ?? "Banorte" // Recuperar la opción guardada de UserDefaults
    @State private var Card_name : String = ""
    @State private var Card_num: String = ""
    @State private var Expiration_date: String = ""
    @State private var CVV : String = ""
    @State private var showSelectCardSheet = false
    @State private var showAddNewCardSheet = false

    @State var cards = ["Banorte" , "Banamex", "Master Card", "Visa"]
    @State private var selectedCardIndex = 0
    
    var body: some View {
        ZStack {
            // First, overlay the content on top
            colorP.rojo // Use the background color directly as the ZStack's background
                .frame(maxWidth: .infinity)
                .frame(height: 80) // Increase the height of the background
                .cornerRadius(15)
                .padding(20) // Apply padding directly to the background
            
            HStack {
                Button(action: {
                    showSelectCardSheet.toggle()
                }) {
                    Text("CambiarTarjeta")
                        .font(.system(size: 17 , weight: .heavy, design: .rounded))
                        .foregroundColor(colorP.barraBlanco)
                        .padding(10)
                        .background(colorP.rojoClaro)
                        .cornerRadius(8)
                        .offset(x:40)
                }
                .sheet(isPresented: $showSelectCardSheet) {
                    VStack {
                        Picker("Seleccionar Tarjeta", selection: $selectedCardIndex) {
                            ForEach(0..<cards.count, id: \.self) { index in
                                Text(cards[index]).tag(index)
                            }
                        }
                        .pickerStyle(.wheel)
                        .padding()
                        
                        Button(action: {
                            // Save the selected card as the cardSelection
                            cardSelection = cards[selectedCardIndex]
                            UserDefaults.standard.set(cardSelection, forKey: "SelectedCard")
                            
                            // Dismiss the sheet
                            showSelectCardSheet = false
                        }) {
                            Text("Aceptar")
                                .foregroundColor(.white)
                                .padding()
                                .background(colorP.rojo)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .presentationDetents([.height(300)])
                }
                
                Spacer()
                
                Button(action: {
                    showAddNewCardSheet.toggle()
                }) {
                    Text("Añadir Tarjeta")
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundColor(colorP.barraBlanco)
                        .padding(10)
                        .background(colorP.rojoClaro)
                        .cornerRadius(8)
                        .offset(x:-40)
                }
                .sheet(isPresented: $showAddNewCardSheet) {
                    NewCardView(card_num: $Card_num, card_name: $Card_name, expiration_date: $Expiration_date, cvv: $CVV, cards: $cards, showAddNewCardSheet: $showAddNewCardSheet)
                }
            }
        }
    }
}

struct NewCardView: View {
    @Binding var card_num: String
    let colorP = ColorPalette()
    @Binding var card_name: String
    @Binding var expiration_date: String
    @Binding var cvv: String
    @Binding var cards: [String]
    @Binding var showAddNewCardSheet: Bool

    var body: some View {
        VStack {
            TextField("Numero de Tarjeta", text: $card_num)
                .textFieldStyle(.roundedBorder)
                .font(.system(size: 35, weight: .heavy, design: .rounded)) // Increase text size
            TextField("Nombre de Tarjeta", text: $card_name)
                .textFieldStyle(.roundedBorder)
                .font(.system(size: 35, weight: .heavy, design: .rounded)) // Increase text size
            GeometryReader { geometry in
                HStack {
                    TextField("Fecha de Expiracion", text: $expiration_date)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 14, weight: .heavy, design: .rounded))
                        .font(.system(size: geometry.size.width * 0.06)) // Adjust font size relative to width
                    
                    
                    TextField("CVV", text: $cvv)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 14, weight: .heavy, design: .rounded))
                }
                .frame(width: geometry.size.width * 1, height: geometry.size.height * 0.7)
            }
            Button(action: {
                if !card_name.isEmpty {
                    cards.append(card_name)
                    card_name = ""
                }
                showAddNewCardSheet = false
            }) {
                Text("Aceptar")
                    .foregroundColor(.white)
                    .padding()
                    .background(colorP.rojo)
                    .cornerRadius(8)
            }
        }
        .padding()
        .presentationDetents([.height(300)])
    }
}


#Preview{
    ProfileView(dWidth: 300, dHeight: 400)
}
