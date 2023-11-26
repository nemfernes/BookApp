import Foundation
import FirebaseRemoteConfigInternal

class FirebaseManager {
    
    static let instance = FirebaseManager()
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    func fetchHome(completion: @escaping (FirebaseResponse?) -> Void) {
        remoteConfig.fetch { status, error in
            if status == .success {
                self.remoteConfig.activate { _, _ in
                    let value = self.remoteConfig.configValue(forKey: "json_data").stringValue ?? ""
                    if let data = value.data(using: .utf8) {
                        do {
                            let response = try JSONDecoder().decode(FirebaseResponse.self, from: data)
                            completion(response)
                        } catch {
                            completion(nil)
                        }
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchDetail(completion: @escaping (FirebaseResponse?) -> Void) {
        remoteConfig.fetch { status, error in
            if status == .success {
                self.remoteConfig.activate { _, _ in
                    let value = self.remoteConfig.configValue(forKey: "details_carousel").stringValue ?? ""
                    
                    if let data = value.data(using: .utf8) {
                        do {
                            let response = try JSONDecoder().decode(FirebaseResponse.self, from: data)
                            completion(response)
                        } catch {
                            completion(nil)
                        }
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
}
