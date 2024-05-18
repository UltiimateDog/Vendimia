import SwiftUI

struct HistoryView: View {
    var modelData: ModelData = .shared
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @State var index = -1
    let dWidth: Double
    let dHeight: Double
    let colorP = ColorPalette()
    
    let tickets = testTickets().testArray
    
    @State var searchText = ""
    private var searchResults: [Ticket] {
        if !searchText.isEmpty  {
            !intenseSearch ? tickets.filter {
                $0.concept.localizedCaseInsensitiveContains(searchText) ||
                $0.reference.localizedCaseInsensitiveContains(searchText)
            } : tickets.filter { $0.concept.localizedCaseInsensitiveContains(searchText) }
        } else {
            tickets
        }
    }
    @State var intenseSearch = false
    @State var showFilters = false
    @State var filters = ["", "", ""]
    @State var dates = [Date(), Date()]
     
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)

            VStack(spacing: 0) {
                SearchBar(searchText: $searchText, intenseSearch: $intenseSearch, showFilters: $showFilters, dWidth: dWidth, dHeight: dHeight, adSearchText: $filters, dates: $dates)
                    .padding(.bottom, 10)
                ScrollView(showsIndicators: false) {
                    ForEach(searchResults) { articulo in
                        NavigationLink {
                            TicketDisplay(dWidth: dWidth, dHeight: dHeight, data: articulo)
                        } label: {
                            TicketPreview(dWidth: dWidth, dHeight: dHeight, data: articulo)
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: dWidth * 0.06))
            }
            // This padding is for the task bar below
            .padding(safeAreaInsets)
            .padding(.horizontal, 10)
            .padding(.bottom, dWidth / 5 + 10)
        }
        .onAppear {
            intenseSearch = false
            showFilters = false
        }
    }
}

#Preview {
    HistoryView(dWidth: 300, dHeight: 700)
}
