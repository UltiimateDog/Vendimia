import SwiftUI
import LocalAuthentication
import PassKit


struct Main: View {
    @State private var unlocked = false
    @State private var text = "BLOQUEADO"
    @State private var isAuthenticated = false
    @State private var showPayment = false
    @State private var authenticationSuccess = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text(text)
                    .bold()
                    .padding()
                
                Button("Autenticar") {
                    showPayment.toggle()
                }
                .padding()
                .sheet(isPresented: $showPayment) {
                    //ApplePay()
                }
            }
            .navigationBarTitle("Autenticación")
        }
    }
}



struct Product: Identifiable {
    var id = UUID()
    var price: Double
}

struct ApplePay: View {
    @Binding var cost: String
    
    var body: some View {
        PaymentButton(products: [Product(price: Double(cost) ?? 0.00)])
            .frame(minWidth: 100, maxWidth: .infinity, maxHeight: 45)
            .padding()
    }
}

struct PaymentButton: UIViewRepresentable {
    var products: [Product]
    
    func makeCoordinator() -> PaymentManager {
        PaymentManager(products: products)
    }
    
    func makeUIView(context: Context) -> some UIView {
        context.coordinator.button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        context.coordinator.products = products
    }
}

class PaymentManager: NSObject, PKPaymentAuthorizationControllerDelegate {
    var products: [Product]
    var button = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .automatic)
    
    init(products: [Product]) {
        self.products = products
        super.init()
        button.addTarget(self, action: #selector(callBack(_:)), for: .touchUpInside)
    }
    
    @objc func callBack(_ sender: Any) {
        startPayment(products: products)
    }
    
    func startPayment(products: [Product]) {
        var paymentController: PKPaymentAuthorizationController?
        var paymentSummaryItems = [PKPaymentSummaryItem]()
        var totalPrice: Double = 0
        
        products.forEach { product in
            let item = PKPaymentSummaryItem(label: "", amount: NSDecimalNumber(string: "\(product.price.rounded())"),type: .final)
            totalPrice += product.price.rounded()
            paymentSummaryItems.append(item)
        }
        
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "\(totalPrice)"),type: .final)
        paymentSummaryItems.append(total)
        
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.countryCode = "MX"
        paymentRequest.currencyCode = "MXN"
        paymentRequest.supportedNetworks = [.visa,.mada,.masterCard]
        paymentRequest.merchantIdentifier = "merchant.ApplePayButtonSession"
        paymentRequest.merchantCapabilities = .threeDSecure
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        
        paymentController?.delegate = self
        paymentController?.present()
    }
  
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment) async -> PKPaymentAuthorizationResult {
        .init(status: .success, errors: nil)
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
