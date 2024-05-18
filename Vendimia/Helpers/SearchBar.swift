import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var intenseSearch: Bool
    @Binding var showFilters: Bool
    let dWidth: Double
    let dHeight: Double
    let colorP = ColorPalette()
    @Binding var adSearchText: [String]
    @Binding var dates: [Date]
    
    var body: some View {
        ZStack(alignment: .top) {
            // Collapse advanced search
            RoundedRectangle(cornerRadius: dHeight*0.022)
                .fill(colorP.grisOscuro)
                .frame(height: showFilters ? dHeight*0.35 : dHeight*0.03)
                .opacity(0.95)
                .padding(.horizontal, showFilters ? 0 : 20)
                .overlay {
                    advancedSearch()
                }
            // Top Bar
            HStack {
                Button {
                    withAnimation() {
                        intenseSearch = true
                        showFilters = true
                    }
                } label: {
                    Image("custom.mail.and.text.magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(intenseSearch ? .multicolor : .hierarchical)
                        .symbolEffect( .variableColor.iterative.dimInactiveLayers.nonReversing, isActive: intenseSearch)
                        .symbolEffectsRemoved()
                        .foregroundStyle(intenseSearch ? Color.black : colorP.grisOscuro)
                        .frame(height: intenseSearch ? dHeight*0.045 : dHeight*0.035)
                        .fixedSize()
                        .padding(.leading, intenseSearch ? 5 : 0)
                        .padding(.top, intenseSearch ? 3 : 0)
                }
                .padding(.leading, dHeight*0.01)
                TextField("Find a transaction", text: $searchText)
                    .foregroundStyle(colorP.barraBlanco)
                    .bold()
                Button {
                    withAnimation() {
                        searchText = ""
                        adSearchText[0] = ""
                        adSearchText[1] = ""
                        adSearchText[2] = ""
                        intenseSearch = false
                        showFilters = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(colorP.grisOscuro)
                        .frame(height: dHeight*0.022)
                }
            }
            .padding(.trailing, 10)
            .padding(.horizontal, showFilters ? 15 : 0)
            .padding(.top, showFilters ? 10 : 0)
            .background(RoundedRectangle(cornerRadius: dHeight*0.022)
                .fill(colorP.gris)
                .frame(height: intenseSearch ? dHeight*0.05 : dHeight*0.044)
                .padding(.horizontal, showFilters ? 15 : 0)
                .padding(.top, showFilters ? 10 : 0))
        }
    }
    
    func advancedSearch() -> some View {
        ZStack(alignment: .top) {
            // Titulo
            HStack {
                Spacer()
                Text("Concept")
                    .bold()
                    .foregroundStyle(colorP.barraBlanco)
                Spacer()
                TextField("Insert concept", text: $adSearchText[0])
                    .frame(width: dWidth * 0.6)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(colorP.gris)
                            .scaleEffect(CGSize(width: 1.05, height: 1.3))
                    }
            }
            .padding(.top, showFilters ? dHeight*0.05 + 28 : 10)
            .padding(.trailing, 5)
            
            // Autor
            VStack(spacing: 15) {
                if showFilters {
                    Text("Titulo")
                        .opacity(0)
                }
                HStack {
                    Spacer()
                    Text("Reference")
                        .bold()
                        .foregroundStyle(colorP.barraBlanco)
                    Spacer()
                    TextField("Insert reference", text: $adSearchText[1])
                        .frame(width: dWidth * 0.4)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(colorP.gris)
                                .scaleEffect(CGSize(width: 1.05, height: 1.3))
                        }
                }
                .padding(.top, showFilters ? dHeight*0.05 + 28 : 10)
                .padding(.trailing, dWidth * 0.21)
            }
            
            // Fechas
            VStack(spacing: 15) {
                if showFilters {
                    Text("Titulo")
                        .opacity(0)
                    Text("Titulo")
                        .opacity(0)
                }
                HStack {
                    Spacer()
                    Text("Since")
                        .bold()
                        .foregroundStyle(colorP.barraBlanco)
                    Spacer()
                    DatePicker("", selection: $dates[0], displayedComponents: .date)
                        .labelsHidden()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorP.gris)
                                .frame(width: dWidth * 0.29)
                                .padding(.vertical, 2)
                        }
                }
                .padding(.top, showFilters ? dHeight*0.05 + 30 : 5)
                .padding(.trailing, dWidth * 0.21 + 2)
            }
            
            VStack(spacing: 15) {
                if showFilters {
                    Text("Titulo")
                        .opacity(0)
                    Text("Titulo")
                        .opacity(0)
                    Text("Titulo")
                        .opacity(0)
                }
                HStack {
                    Spacer()
                    Text("To")
                        .bold()
                        .foregroundStyle(colorP.barraBlanco)
                    Spacer()
                    DatePicker("", selection: $dates[1], in: ...Date.now, displayedComponents: .date)
                        .labelsHidden()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorP.gris)
                                .frame(width: dWidth * 0.29)
                                .padding(.vertical, 2)
                        }
                }
                .padding(.top, showFilters ? dHeight*0.05 + 34 : 5)
                .padding(.trailing, dWidth * 0.21 + 2)
            }
            
            // Texto
            VStack(spacing: 15) {
                if showFilters {
                    Text("Titulo")
                        .opacity(0)
                    Text("Titulo")
                        .opacity(0)
                    Text("Titulo")
                        .opacity(0)
                    Text("Titulo")
                        .opacity(0)
                }
                HStack {
                    Spacer()
                    Text("Tracking#")
                        .bold()
                        .foregroundStyle(colorP.barraBlanco)
                    Spacer()
                    TextField("Insert tracking number", text: $adSearchText[2], axis: .vertical)
                        .lineLimit(1)
                        .frame(width: dWidth * 0.55)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(colorP.gris)
                                .scaleEffect(CGSize(width: 1.05, height: 1.3))
                        }
                }
                .padding(.top, showFilters ? dHeight*0.05 + 40 : 10)
                .padding(.trailing, 5)
            }
            
            // Cuñita para ocultar
            Button {
                withAnimation() {
                    showFilters = false
                }
            } label: {
                Image(systemName: "control")
                    .resizable()
                    .foregroundStyle(colorP.gris)
                    .frame(width: dWidth * 0.1, height: dWidth * 0.09)
                    .scaleEffect(0.45, anchor: .center)
            }
            .padding(.top, showFilters ? dHeight*0.35 - dWidth * 0.09 + 7: 0)
        }
        .padding(.horizontal, 10)

    }
}
