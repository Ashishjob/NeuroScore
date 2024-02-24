import Foundation
import UIKit

extension DailyScrum {
    static func toCSV() -> String {
            var csvString = "date,time,gcsVision,gcsVerbal,gcsMotor,totalGCS\n"
            
            let dateFormatterDate = DateFormatter()
            dateFormatterDate.dateFormat = "dd-MM-yyyy"
            
            let dateFormatterTime = DateFormatter()
            dateFormatterTime.dateFormat = "HH:mm"
            
            for scrum in sampleData {
                let formattedDate = dateFormatterDate.string(from: scrum.date)
                let formattedTime = dateFormatterTime.string(from: scrum.date)
                let line = "\(formattedDate),\(formattedTime),\(scrum.gcsVision),\(scrum.gcsVerbal),\(scrum.gcsMotor),\(scrum.totalGcs)\n"
                csvString.append(line)
            }
            
            return csvString
        }
    
    static func saveCSVToFile() {
        let csvString = toCSV()
        let filename = "daily_scrums.csv"
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(filename)
            
            do {
                try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
                print("CSV file saved to: \(fileURL)")
                showShareSheet(with: fileURL)
            } catch {
                print("Error writing CSV file: \(error)")
            }
        }
    }
    
    static func generateAndSaveCSV() {
        saveCSVToFile()
    }
    
    private static func showShareSheet(with fileURL: URL) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            print("Unable to find active UIWindowScene.")
            return
        }

        if let rootViewController = windowScene.windows.first?.rootViewController {
            let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            rootViewController.present(activityViewController, animated: true, completion: nil)
        } else {
            print("Unable to find root view controller.")
        }
    }

}
