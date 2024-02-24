import SwiftUI

struct HistoryView: View {
    let history: History
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeString)
                if let transcript = history.transcript {
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map{ $0.name })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var history: History {
            History(attendees: [
                DailyScrum.Attendee(name: "Jon"),
                DailyScrum.Attendee(name: "Darla"),
                DailyScrum.Attendee(name: "Luis")
            ],

            transcript: "Darla, would you to start the meeting today? Sure! I started by reviewing some merge requests, but found some more bugs we need to address...")
        }
    
    static var previews: some View {
        HistoryView(history: history)
    }
}
