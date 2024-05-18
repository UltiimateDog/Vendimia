import SwiftUI

struct PayView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    let dWidth: Double
    let dHeight: Double
    let colorP = ColorPalette()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
            
            TopView(dwidth: dWidth, dHeight: dHeight)
                .padding(safeAreaInsets)
        }
    }
}

#Preview {
    PayView(dWidth: 300, dHeight: 700)
}
