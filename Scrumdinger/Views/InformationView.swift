import SwiftUI
let lightgray = Color(red: 60/255, green: 71/255, blue: 72/255)

struct InformationView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("What is the Glasgow Coma Scale (GCS)?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : lightgray)
                    .padding(.bottom, 10)

                Text("Definition:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : lightgray)
                    .padding(.top, 5)
                
                Text("It’s a scale used to measure the extent of impaired consciousness in trauma (TBI) patients, and it looks at 3 aspects of active responsiveness: vision, verbal, and motor; the scores from each add up to the total Glasgow Coma Score (3 - 15 points)")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Image("gcsDiagram")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)

                GCSComponentView(title: "Vision [eye-opening response]:", image: "eye.fill", options: [
                    "1 : No eye opening",
                    "2 : Eye opening to pain",
                    "3 : Eye opening to sound",
                    "4 : Eyes open spontaneously"
                ])

                GCSComponentView(title: "Verbal [verbal response to speech]:", image: "mouth.fill", options: [
                    "1 : No verbal response",
                    "2 : Incomprehensible sounds",
                    "3 : Inappropriate words",
                    "4 : Confused",
                    "5 : Orientated"
                ])

                GCSComponentView(title: "Motor [physical responses]:", image: "hand.raised.fill", options: [
                    "1 : No motor response",
                    "2 : Abnormal extension to pain",
                    "3 : Abnormal flexion to pain",
                    "4 : Withdrawal from pain",
                    "5 : Localizing pain",
                    "6 : Obeys commands"
                ])
                
                Text("Why does the GCS Test matter?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : lightgray)
                    .padding(.top, 5)

                Text("GCS helps with early management of patients and is critical in monitoring the clinical course of a patient and guiding changes in management")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Text("How accurate is this test?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : lightgray)
                    .padding(.top, 5)

                Text("The Glasgow Coma Scale's accuracy can be affected by factors such as language barriers, hearing loss, and intellectual/neurological deficits. Intubation, sedation, and specific injuries like orbital/cranial fractures and spinal cord damage may limit GCS responses. Hypoxic-ischemic encephalopathy can also impact assessments.")
                    .font(.body)
                    .foregroundColor(Color.secondary)
                    .padding(.top, 10)

                Text("Ultimately, the score is usually not calculated if any of the 3 parts of the GCS test cannot be appropriately obtained, as it would skew the score too far negative.")
                    .font(.body)
                    .foregroundColor(.secondary)

                Text("Learn More:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : lightgray)
                    .padding(.top, 20)
                
                Link("Glasgow Coma Scale - StatPearls - NCBI Bookshelf", destination: URL(string: "https://www.ncbi.nlm.nih.gov/books/NBK513298/")!)
                    .font(.body)
                    .foregroundColor(colorScheme == .dark ? .white : lightgray)
                    .padding(.top, 5)

                Text("The information provided here is for educational purposes only and is not intended as medical advice. Consult a medical professional for personalized advice.")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
            }
            .padding()
        }
    }
}

struct GCSComponentView: View {
    @Environment(\.colorScheme) var colorScheme

    var title: String
    var image: String
    var options: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: image)
                    .foregroundColor(colorScheme == .dark ? .white : lightgray)
                    .imageScale(.medium)
                Text(title)
                    .font(.title3)
                    .foregroundColor(colorScheme == .dark ? .white : lightgray)
            }
            ForEach(options, id: \.self) { option in
                HStack {
                    Spacer().frame(width: 20) // Additional indentation
                    Text("‐")
                        .font(.body)
                        .foregroundColor(colorScheme == .dark ? .white : lightgray)
                    Text(option)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.leading, 10)
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
