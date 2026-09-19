import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let loadingVC = LoadingViewController()
        window?.rootViewController = loadingVC
        window?.makeKeyAndVisible()

        // Kiểm tra UID qua Web GET
        DeviceManager.verifyUID { authorized in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                if authorized {
                    let introVC = IntroViewController()
                    self.window?.rootViewController = introVC
                } else {
                    let errorVC = ErrorViewController(
                        title: "Truy cập bị từ chối",
                        message: "UID thiết bị không được cấp quyền sử dụng app."
                    )
                    self.window?.rootViewController = errorVC
                }
            }
        }
        return true
    }
}
