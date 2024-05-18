import SwiftUI

struct ContainerView: View {
    @State private var isSplashScreenViewPresented = true
    @State var gotoApp = false // Change to false to see splashScreen
    @State var isLogin = true

    var body: some View {
        if gotoApp {
            if isLogin {
                LoginView(isLogin: $isLogin)
            } else {
                NavigationBarView()
            }
        } else {
            if !isSplashScreenViewPresented {
                LoginView(isLogin: $isLogin)
                    .onAppear {
                        gotoApp = true
                    }
            } else {
                SplashScreenView(isPresented: $isSplashScreenViewPresented)
            }
        }
    }
}

#Preview {
    ContainerView()
}
