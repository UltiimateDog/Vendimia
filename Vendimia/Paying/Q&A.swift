import SwiftUI

struct QuestionAnswer {
    let question: String
    let answer: String
}

let questionAnswers = [
    QuestionAnswer(question: "¿Quiénes somos?", answer: "Somos una aplicación que busca el acceso de dinero digital para todos, logrando practicidad a todos los usuarios implementando tecnologías como pago con reconocimiento facial."),
    QuestionAnswer(question: "Nuestra misión", answer: "Empoderar a todos los mexicanos para transitar hacia una economía digital, reduciendo la dependencia del efectivo y promoviendo la inclusión financiera a través de nuestra plataforma fácil de usar"),
    QuestionAnswer(question: "Recompensas", answer: """
1. Electrodomésticos: Canjear puntos por electrodomésticos como microondas, licuadoras, entre otros.\n
2. Viajes: Ofrece la posibilidad de canjear puntos por viajes nacionales\n
3. Experiencias Exclusivas: Incluye experiencias como cenas en restaurantes de renombre.\n
4. Descuentos y Promociones: Alianzas con comercios locales para ofrecer descuentos exclusivos o promociones al pagar con la app.
"""),
    QuestionAnswer(question: "Contacto", answer: "Correo Electrónico: contacto@vendimiaapp.mx\n\n Teléfono de Soporte: 800-123-4567\n")
]

struct Q_A: View {
    let questions = questionAnswers
    
    var body: some View {
        NavigationView {
            List(questions, id: \.question) { qa in
                NavigationLink(destination: DetailView(questionAnswer: qa)) {
                    HStack {
                        Image(systemName: "message.fill")
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                        Text(qa.question)
                            .font(.system(size: 20))
                            .bold()
                    }.padding(.bottom, 5)
                }
            }
            .navigationTitle("Dudas frecuentes")
        }
    }
}

struct DetailView: View {
    var questionAnswer: QuestionAnswer
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) { // Ajusta aquí para centrar
            Text(questionAnswer.question)
                .font(.system(size: 40))
                .bold()
            
            Text(questionAnswer.answer)
                .font(.system(size: 25))
                .padding(.top, 10)
                .multilineTextAlignment(.center) // Asegúrate de que el texto está centrado
            
            Spacer()
        }
        .padding()
    }
}

struct Q_A_Previews: PreviewProvider {
    static var previews: some View {
        Q_A()
    }
}
