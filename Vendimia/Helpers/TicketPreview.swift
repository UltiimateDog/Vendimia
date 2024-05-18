import SwiftUI

struct TicketPreview: View {
    var modelData: ModelData = .shared
    let dWidth: Double
    let dHeight: Double
    let colorP = ColorPalette()
    let data: Ticket
    
    var body: some View {
        RoundedRectangle(cornerRadius: dWidth * 0.05)
            .fill(colorP.gris)
            .frame(height: dHeight * 0.1)
            .overlay {
                HStack {
                    data.ticketImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: dHeight * 0.08)
                        .foregroundStyle(colorP.grisOscuro)
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text(data.concept)
                                .font(.headline)
                                .bold()
                                .foregroundStyle(Color.black)
                                .lineLimit(1)
                            Spacer()
                            data.ticket_arrow
                                .foregroundStyle(data.ticket_color)
                                .fontWeight(.black)
                            Text("$ " + String(data.quantity))
                                .font(.title3)
                                .italic()
                                .foregroundStyle(data.ticket_color)
                        }
                        Spacer()
                        HStack {
                            Text(data.reference)
                                .font(.caption)
                                .italic()
                                .lineLimit(1)
                                .foregroundStyle(Color.black)
                            Spacer()
                            Text(data.date, style: .time)
                                .font(.caption)
                                .italic()
                                .lineLimit(1)
                                .foregroundStyle(Color.black)
                            Text(data.date, style: .date)
                                .font(.caption)
                                .italic()
                                .lineLimit(1)
                                .foregroundStyle(Color.black)
                        }
                    }
                }
                .padding(.all, 10)
            }
            .padding(.vertical, 5)
    }
}


#Preview {
    TicketPreview(dWidth: 300, dHeight: 700, data: testTickets().a1)
}
