import SwiftUI
import CoreData

struct ContentView: View {
    @State private var predicacionHoras = ""
    @State private var mensaje = ""
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            Text("Registrar Horas Predicadas")
                .font(.largeTitle)
                .padding()
            
            TextField("Ingrese las horas predicadas", text: $predicacionHoras)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                guardarHoras()
            }) {
                Text("Guardar")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Text(mensaje)
                .font(.subheadline)
                .padding()
        }
        .padding()
    }
    
    func guardarHoras() {
        guard let horas = Double(predicacionHoras) else {
            mensaje = "Por favor, ingrese un número válido."
            return
        }
        
        let nuevaPredicacion = Predicacion(context: viewContext)
        nuevaPredicacion.horas = horas
        nuevaPredicacion.fecha = Date()
        
        do {
            try viewContext.save()
            mensaje = "Horas guardadas exitosamente"
        } catch {
            mensaje = "Error al guardar las horas"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
