import SwiftUI

struct PointsProgressBar: View {
    var modelData: ModelData = .shared
    @State private var anim = false
    let dWidth: Double
    let dHeight: Double
    let colorP = ColorPalette()
    let option = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                Rectangle()
                    .fill(
                        LinearGradient(colors: option ? [Color.green, colorP.rojoClaro] : [colorP.c5, Color.green], startPoint: .top, endPoint: .bottom)
                    )
                    .frame(height: dHeight*0.32 * Double(modelData.profile.currentPoints) / Double(modelData.profile.goalPoints))
            }
        }
        .frame( width: dWidth*0.4, height:dHeight*0.32)
        .overlay {
            Image("planet")
                .resizable()
                .scaledToFit()
                .frame(width: dWidth*0.25)
                .scaleEffect(x: anim ? 1.1 : 1, y: anim ? 1.1 : 1)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        anim.toggle()
                    }
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: dWidth * 0.0636, style: .continuous))
        .padding(.all, 5)
        .padding(.leading, 5)
    }
}

#Preview {
    PointsProgressBar(dWidth: 300, dHeight: 700)
}
