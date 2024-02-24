import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    @State private var newAttendeeName = ""
    @State private var sideNote = ""

    var body: some View {
        Form {
            Section(header: Text("Log Info")) {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes)")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
            }

            Section(header: Text("GCS Scores")) {
                TextField("Vision Score", text: Binding(
                    get: { scrum.gcsVision },
                    set: { scrum.gcsVision = DailyScrum.validateGCSValue($0, min: 1, max: 4) }
                ))
                TextField("Verbal Score", text: Binding(
                    get: { scrum.gcsVerbal },
                    set: { scrum.gcsVerbal = DailyScrum.validateGCSValue($0, min: 1, max: 5) }
                ))
                TextField("Motor Score", text: Binding(
                    get: { scrum.gcsMotor },
                    set: { scrum.gcsMotor = DailyScrum.validateGCSValue($0, min: 1, max: 6) }
                ))
            }

            VStack {
                Spacer()
                HStack {
                    Text("Total GCS Score: ").fontWeight(.bold)
                    Spacer()
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                HStack {
                    Spacer()
                    Text("\(scrum.totalGcs)")
                        .font(.system(size: 75, weight: .bold)).underline()
                    Spacer()
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            
            Section(header: Text("Side Note")) {
                TextField("Enter Side Notes", text: $sideNote)
            }
        }
        .onDisappear {
            scrum.sideNote = sideNote
        }
        .navigationBarTitle(Text("Add GCS Score"))
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        let scrum = DailyScrum.sampleData[0]
        return NavigationView {
            DetailEditView(scrum: .constant(scrum))
                .background(scrum.theme.mainColor)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .previewLayout(.fixed(width: 400, height: 600))
    }
}
