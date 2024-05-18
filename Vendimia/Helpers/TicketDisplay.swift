import SwiftUI

struct TicketDisplay: View {
    let dWidth: Double
    let dHeight: Double
    let data: Ticket
    let colorP = ColorPalette()
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(colorP.grisOscuro)
                .opacity(0.8)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                VStack(spacing: 10) {
                    Image(systemName: "checkmark.gobackward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: dWidth*0.2)
                        .foregroundStyle(colorP.verde)
                    Text(data.money_in ? "$ " + String(data.quantity) : "-$ " + String(data.quantity))
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(data.ticket_color)
                    Text("Established")
                        .italic()
                        .foregroundStyle(Color.black)
                    HStack {
                        Text(data.date, style: .time)
                        Text(data.date, style: .date)
                    }
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color.black)
                }
                .padding(.vertical, 10)
                .background {
                    Rectangle()
                        .fill(colorP.gris)
                        .frame(width: dWidth)
                }
                Group {
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.blue)
                            .frame(width: dWidth*0.07)
                    }
                    Text("Download voucher")
                        .fontWeight(.light)
                        .foregroundStyle(Color.black)

                }
                .frame(width: dWidth)
                .padding(.bottom, 5)
                .background(Color.white)
                Divider()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text("Tracking key")
                            .foregroundStyle(Color.gray)
                        Text(data.tracking_key)
                            .foregroundStyle(Color.black)
                        Spacer(minLength: 10)
                        
                        Text("Transaction")
                            .foregroundStyle(Color.gray)
                        Text(data.transaction)
                            .foregroundStyle(Color.black)
                        Spacer(minLength: 10)
                        
                        Text("Receiver account")
                            .foregroundStyle(Color.gray)
                        Text(String(repeating: ".", count: 12) + data.reciever_account.suffix(4))
                            .foregroundStyle(Color.black)
                        Spacer(minLength: 10)
                        
                        Text("Giver account")
                            .foregroundStyle(Color.gray)
                        Text(String(repeating: ".", count: 12) + data.giver_account.suffix(4))
                            .foregroundStyle(Color.black)
                        Spacer(minLength: 10)
                        
                        Text("Receiver bank")
                            .foregroundStyle(Color.gray)
                        Text(data.reciever_bank)
                            .foregroundStyle(Color.black)
                        Spacer(minLength: 10)
                        
                        Text("Concept")
                            .foregroundStyle(Color.gray)
                        Text(data.concept)
                            .foregroundStyle(Color.black)
                        Spacer(minLength: 10)
                        
                        Text("Reference")
                            .foregroundStyle(Color.gray)
                        Text(data.reference)
                            .foregroundStyle(Color.black)
                        Spacer(minLength: 10)
                        
                        Text("Account name")
                            .foregroundStyle(Color.gray)
                        Text(data.account_name)
                            .foregroundStyle(Color.black)
                        Spacer(minLength: 10)
                        
                        Text("Comision")
                            .foregroundStyle(Color.gray)
                        Text(String(data.comision))
                            .foregroundStyle(Color.black)
                        Spacer(minLength: 10)
                        
                        Text("IVA Comision")
                            .foregroundStyle(Color.gray)
                        Text(String(data.IVA_comision))
                            .foregroundStyle(Color.black)
                        Spacer(minLength: 10)
                        
                    }
                    .padding(.horizontal, 15)
                }
                .frame(width: dWidth, alignment: .leading)
                .padding(.top, 5)
                .background(Color.white)
            }
        }
    }
}

/*
#Preview {
    TicketDisplay(dWidth: 300, dHeight: 700, data: testArticles().A6)
} */
