import SwiftUI

struct NavigationBarView: View {
    @State var currentTab: Tab = .Pay
    let colorP = ColorPalette()
    
    // Hide native bar
    init () {
        UITabBar.appearance().isHidden = true
    }
        
    var body: some View {
        GeometryReader { proxy in
            let dHeight = proxy.size.height
            let dWidth = proxy.size.width
            
            NavigationStack {
                TabView(selection: $currentTab) {
                    HistoryView(dWidth: dWidth, dHeight: dHeight)
                        .ignoresSafeArea()
                        .ignoresSafeArea(.keyboard)
                        .tag(Tab.History)
                    ProfileView(dWidth: dWidth, dHeight: dHeight)
                        .ignoresSafeArea()
                        .tag(Tab.Profile)
                    PayView(dWidth: dWidth, dHeight: dHeight)
                        .ignoresSafeArea()
                        .ignoresSafeArea(.keyboard)
                        .tag(Tab.Pay)
                }
                .overlay(alignment: .bottom) {
                    HStack(spacing: 0) {
                        ForEach (Tab.allCases, id: \.rawValue) { tab in
                            TabButton(tab: tab, dWidth: dWidth)
                        }
                        .padding(.bottom, 5)
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(colorP.barraBlanco)
                            .strokeBorder(colorP.rojo, lineWidth: 7)
                            .frame(width: dWidth*1.05,height: dWidth*0.35)
                            .offset(y: dWidth*0.05)
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
    
    func TabButton(tab: Tab, dWidth: Double) -> some View {
        Button {
            withAnimation(.spring()) {
                currentTab = tab
            }
        } label: {
            ZStack {
                Circle()
                    .fill(currentTab == tab ? LinearGradient(colors: [colorP.barraBlanco], startPoint: .top, endPoint: .bottom) : LinearGradient(colors: [Color.clear], startPoint: .top, endPoint: .bottom))
                    .stroke(currentTab == tab ? colorP.rojo : Color.clear, lineWidth: 7)
                    .offset(y: currentTab == tab ? -35 : 0)
                    .frame(height: dWidth / 4)
                Image(systemName: currentTab == tab ? tab.rawValue + ".fill": tab.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: tab == Tab.Pay ? 65 : 38)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.black)
                    .fontWeight(.medium)
                    .contentShape(Rectangle())
                    .offset(y: currentTab == tab ? -35 : 0)
            }
        }
    }
}

// These lines are used to maintain the slide feature to go back to another view
// These are not actually use in this app
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

// Tabbar enum
enum Tab: String, CaseIterable {
    case Profile = "person"
    case Pay = "dollarsign.circle"
    case History = "book.pages"
    //case New = "rectangle.portrait.and.arrow.right"
    
    var tabName: String {
        switch self {
        case .Profile:
            return "Profile"
        case .Pay:
            return "Pay"
        case .History:
            return "History"
        }
    }
}

#Preview {
    NavigationBarView()
}
