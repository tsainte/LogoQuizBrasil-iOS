import UIKit
import Fabric
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: ApplicationCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        startServices()

        window = UIWindow(frame: UIScreen.main.bounds)
        startCoordinator()
        return true
    }

    func startCoordinator() {
        guard let window = window else {
            fatalError("Can't instantiate basic components")
        }
        coordinator = ApplicationCoordinator(window: window)
        coordinator?.start()
    }
}

// MARK: Services
extension AppDelegate {
    func startServices() {
        //TODO: Fabric
        Flurry.startSession("YOUR_FLURRY_ID")
        startFirebase()
    }

    func startFirebase() {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start { (GADInitializationStatus) in
            print("🔉 Admob started with status: \(GADInitializationStatus)")
        }
    }
}
