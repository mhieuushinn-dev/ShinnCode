import UIKit

class DeviceManager {

    static func getDeviceUID() -> String {
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            return uuid
        }
        return "UNKNOWN_DEVICE_UID"
    }

    private static let verifyURL = "https://raw.githubusercontent.com/mhieuushinn-dev/ShinnCheat/main/uid_verify.json"

    static func verifyUID(completion: @escaping (Bool) -> Void) {
        let currentUID = getDeviceUID()
        
        guard let url = URL(string: verifyURL) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                DispatchQueue.main.async { completion(false) }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data else {
                DispatchQueue.main.async { completion(false) }
                return
            }
            
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data) as? [String] {
                    let isAuthorized = jsonArray.contains(currentUID)
                    DispatchQueue.main.async { completion(isAuthorized) }
                } else if let jsonDict = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                          let allowedUIDs = jsonDict["allowed_uids"] as? [String] {
                    let isAuthorized = allowedUIDs.contains(currentUID)
                    DispatchQueue.main.async { completion(isAuthorized) }
                } else {
                    DispatchQueue.main.async { completion(false) }
                }
            } catch {
                DispatchQueue.main.async { completion(false) }
            }
        }.resume()
    }
}
