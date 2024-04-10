//
//  ios_stationsTests.swift
//  ios-stationsTests
//

import XCTest
import WebKit
@testable import ios_stations

class ios_stationsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStation1() throws {
        let url = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("ios-stations/testResources/station1.png")
        XCTAssertNotNil(try? Data(contentsOf: url), "station1.pngがios-stations/testResourcesフォルダ内に作成されていません")
    }
    
    func testStation2() throws {
        let bundleIdentifier = try XCTUnwrap(Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String, "CFBundleIdentifierが設定されていません")
        XCTAssertEqual(bundleIdentifier, "jp.co.techbowl.ios-stations-user", "適切なCFBundleIdentifierが設定されていません")
    }
    
    func testStation3() throws {
        let url = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("ios-stations/testResources/station3.png")
        let data = try XCTUnwrap(try? Data(contentsOf: url), "station3.pngがios-stations/testResourcesフォルダ内に作成されていません")
        let image = UIImage(data: data)
        
        XCTAssertEqual(image?.cgImage?.width, 1170, "station3.pngが指定したサイズと異なっています")
        XCTAssertEqual(image?.cgImage?.height, 2532, "station3.pngが指定したサイズと異なっています")
    }
    
    func testStation4() throws {
        let view = FirstViewController().view
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        let referenceRed = 0.816
        let referenceGreen = 0.337
        let referenceBlue = 0.576
        let referenceAlpha = 1.0
        
        // 許容誤差
        let range = 0.01
        
        let backgroundColor = try XCTUnwrap(view?.backgroundColor, "view.backgroundColorが設定されていません")
        backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        XCTAssertEqual(backgroundColor, UIColor.Theme.main, "背景色が指定された色と異なっています")

        XCTAssertTrue(((referenceRed - range)...(referenceRed + range)).contains(Double(red)), "Redの値が指定した色と異なっています")
        XCTAssertTrue(((referenceGreen - range)...(referenceGreen + range)).contains(Double(green)), "Greenの値が指定した色と異なっています")
        XCTAssertTrue(((referenceBlue - range)...(referenceBlue + range)).contains(Double(blue)), "Blueの値が指定した色と異なっています")
        XCTAssertTrue(((referenceAlpha - range)...(referenceAlpha + range)).contains(Double(alpha)), "Opacityの値が指定した色と異なっています")
    }
    
    func testStation5() throws {
        let infoPlistUrl = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("ios-stations/ja.lproj/InfoPlist.strings")
        let infoPlist = try XCTUnwrap(NSDictionary(contentsOf: infoPlistUrl), "InfoPlist.stringsに適切なlocalize設定がされていません")
        let displayName = try XCTUnwrap(infoPlist["CFBundleDisplayName"] as? String, "CFBundleDisplayNameが設定されていません")
        XCTAssertEqual(displayName, "iOSステーション", "日本語のアプリ名が指定したものと異なっています")

        let appUrl = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("ios-stations/Assets.xcassets/AppIcon.appiconset/Contents.json")
        let data = try XCTUnwrap(try? Data(contentsOf: appUrl), "アプリアイコンが設定されていません")
        XCTAssertGreaterThan(data.count, 3000, "全てのアプリアイコンが設定されていません")
    }
    
    func testStation6() throws {
        let vc = try XCTUnwrap(loadInitialViewController(), "StoryboardのInitialViewControllerが設定されていません")
        XCTAssertTrue(vc is FirstViewController, "FirstViewControllerがInitialViewControllerとして設定されていません")
        
        let label = try XCTUnwrap(vc.view.subviews.first(where: { $0 is UILabel }) as? UILabel, "ラベルが作成されていません")
        XCTAssertEqual(label.text, "Hello World", "ラベルの文言が指定されたものと異なっています")
    }
    
    func testStation7() throws {
        let vc = try XCTUnwrap(loadInitialViewController(), "StoryboardのInitialViewControllerが設定されていません")
        XCTAssertTrue(vc is FirstViewController, "FirstViewControllerがInitialViewControllerとして設定されていません")

        let label = try XCTUnwrap(vc.view.subviews.first(where: { $0 is UILabel }) as? UILabel, "ラベルが作成されていません")
        
        XCTAssertEqual(label.text, "Hello World", "ラベルの文言が指定されたものと異なっています")
        XCTAssertEqual(label.font.fontName, "Arial-BoldMT", "ラベルのフォントファミリー、スタイルが指定されたものと異なっています")
        XCTAssertEqual(label.font.pointSize, 18, "ラベルのフォントサイズが指定されたものと異なっています")
        XCTAssertEqual(label.textColor, UIColor.white, "ラベルのテキスト色が指定されたものと異なっています")
        XCTAssertEqual(label.backgroundColor, UIColor.Theme.main, "ラベルの背景色が指定されたものと異なっています")
        
        XCTAssertNotNil(label.superview?.centerXAnchor, "ラベルからSuperViewに対するCenter X Constraintが設定されていません")
        XCTAssertNotNil(label.superview?.centerYAnchor, "ラベルからSuperViewに対するCenter Y Constraintが設定されていません")
        XCTAssertNotNil(label.superview?.leadingAnchor, "ラベルからSuperViewに対するLeading Constraintが設定されていません")
        
        XCTAssertTrue(label.constraints.contains(where: { return $0.constant == 44 }), "ラベルに適切なHeight Constraintが設定されていません")
    }
    
    func testStation8() throws {
        let vc = try XCTUnwrap(loadInitialViewController(), "StoryboardのInitialViewControllerが設定されていません")
        XCTAssertTrue(vc is FirstViewController, "FirstViewControllerがInitialViewControllerとして設定されていません")
        
        let button = try XCTUnwrap(vc.view.subviews.first(where: { $0 is UIButton }) as? UIButton, "ボタンが作成されていません")
        XCTAssertEqual(button.frame.size, CGSize(width: 200, height: 44), "ボタンのサイズが適切に設定されていません")
        XCTAssertEqual(button.backgroundColor, UIColor.Theme.main, "ボタンの背景色が指定されたものと異なっています")
        XCTAssertTrue(button.constraints.contains(where: { $0.constant == 200}), "ボタンに適切なWidth Constraintが設定されていません")
        XCTAssertTrue(button.constraints.contains(where: { $0.constant == 44}), "ボタンに適切なHeight Constraintが設定されていません")
        
        let titleLabel = try XCTUnwrap(button.titleLabel, "ボタンのラベルテキストが設定されていません")
        XCTAssertEqual(titleLabel.text, "Click", "ボタンのラベルテキストがClickに設定されていません")
        XCTAssertEqual(titleLabel.textColor, UIColor.white, "ボタンのラベルテキストの背景色が指定されたものと異なっています")
        XCTAssertEqual(titleLabel.font, UIFont(name: "Arial-BoldMT", size: 18), "ボタンのフォントが適切に設定されていません")
    }
    
    // MARK: station9は面談
    
    func testStation10() throws {
        let window = UIWindow()
        let vc = try XCTUnwrap(loadInitialViewController(in: window), "StoryboardのInitialViewControllerが設定されていません")
        
        let button = try XCTUnwrap(vc.view.subviews.first(where: { $0 is UIButton }) as? UIButton, "ボタンが作成されていません")
        
        guard let actions = button.actions(forTarget: vc, forControlEvent: .touchUpInside) else {
            XCTFail("UIButtonのtouchUpInsideイベントにメソッドが関連付けされていません")
            return
        }

        XCTAssertTrue(actions.contains(where: {$0.contains("presentSecondViewController")}), "UIButtonにpresentSecondViewControllerメソッドが関連付けされていません")
        button.tap()
        
        let secondVC = try XCTUnwrap(vc.presentedViewController, "遷移先のViewControllerが設定されていません")
        XCTAssertTrue(secondVC is SecondViewController, "遷移先のViewControllerがSecondViewControllerとして設定されていません")
        
        let webView = try XCTUnwrap(secondVC.view as? WKWebView, "遷移先のviewにWKWebViewが設定されていません")
        XCTAssertNil(webView.url?.absoluteString, "SecondViewControllerのurlに適切な値が設定されていません")
    }
    
    func testStation11() throws {
        let window = UIWindow()
        let vc = try XCTUnwrap(loadInitialViewController(in: window), "StoryboardのInitialViewControllerが設定されていません")
        
        let button = try XCTUnwrap(vc.view.subviews.first(where: { $0 is UIButton }) as? UIButton, "ボタンが作成されていません")
        
        guard let actions = button.actions(forTarget: vc, forControlEvent: .touchUpInside) else {
            XCTFail("UIButtonのtouchUpInsideイベントにメソッドが関連付けされていません")
            return
        }
        
        XCTAssertTrue(actions.contains(where: {$0.contains("presentSecondViewController")}), "UIButtonにpresentSecondViewControllerメソッドが関連付けされていません")
        
        button.tap()
        
        let secondVC = try XCTUnwrap(vc.presentedViewController, "遷移先のViewControllerが設定されていません")
        XCTAssertTrue(secondVC is SecondViewController, "遷移先のViewControllerがSecondViewControllerとして設定されていません")

        let webView = try XCTUnwrap(secondVC.view as? WKWebView, "遷移先のviewにWKWebViewが設定されていません")
        XCTAssertEqual(webView.url?.absoluteString, "https://techbowl.co.jp/", "SecondViewControllerのurlに適切な値が設定されていません")
    }
    
    func testStation12() throws {
        // Bookモデルのプロパティ作成もstationにいれているため、Bookモデル経由ではなくJSONからインスタンス化
        let data = """
            [
                {
                    "id": "hgoeidlogaMaVsL6k9Bdda",
                    "title": "Kubernetes完全ガイド 第2版 impress top gearシリーズ ",
                    "url": "https://www.amazon.co.jp/dp/B08FZX8PYW/ref=cm_sw_em_r_mt_dp_7NDC2QCY40JYYR6RE3KJ",
                    "detail": "Kubernetes解説書の決定版がついに改訂！\\n\\n        Kubernetesはコンテナ化されたアプリケーションのデプロイ、スケーリングなどの管理を自動化する「コンテナオーケストレーションエンジン」です。「クラウドネイティブ」を実現するためのコア技術として、現在多くのシステムでの利用が進んでいます。\\n\\n        本書では、アプリケーション開発者やインフラエンジニアを対象に、Kubernetesの機能やそのエコシステムについて網羅的に解説します。好評をいただいた前版を全面的に見直し、バージョン1.18に対応しました（アルファ機能を含む）。前版以降に追加された機能や変更点にも言及し、最新のKubernetesを活用するための多くの知見を提供します。",
                    "review": "めちゃくちゃわかりやすかった！",
                    "reviewer": "テストユーザ1"
                }
            ]
        """.data(using: .utf8)!
        let expectation = self.expectation(description: "mock request")
        
        XCTAssertNoThrow(try JSONDecoder().decode([Book].self, from: data), "適切なプロパティが設定されていません")
        let decodedBooks = try! JSONDecoder().decode([Book].self, from: data)
        var mockBooks: [Book]!
        
        let client = MockBookAPIClient(books: decodedBooks)
        client.fetchBooks(offset: 0) { books in
            mockBooks = books
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(mockBooks.count, 1)

        let rawModel = mockBooks.first.debugDescription
        let keys = ["id", "title", "url", "detail", "review", "reviewer"]
        for key in keys {
            XCTAssertTrue(rawModel.contains("\(key):"), "適切なプロパティが設定されていません")
        }
    }
    
    func testStation13() throws {
        let url = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("ios-stations.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved")
        let data = try XCTUnwrap(try? Data(contentsOf: url), "SwiftPackageManagerが設定されていないか、対応していないバージョンです")
        
        let json = try XCTUnwrap(try JSONSerialization.jsonObject(with: data) as? Dictionary<String, Any>, "パッケージ情報の取得に失敗しました")
        let packageVersion = try XCTUnwrap(json["version"] as? Int, "パッケージ情報の取得に失敗しました")

        var isAlamofireVersionMatched: Bool? = nil

        switch packageVersion {
        case 1:
            let model = try JSONDecoder().decode(SwiftPMv1.self, from: data)
            let alamofirePin = try XCTUnwrap(model.object.pins.first(where: { $0.package.lowercased() == "alamofire" }), "SwiftPackageManager経由でAlamofireがインストールされていません")
            isAlamofireVersionMatched = alamofirePin.state.version == "5.4.3"
        case 2:
            let model = try JSONDecoder().decode(SwiftPMv2.self, from: data)
            let alamofirePin = try XCTUnwrap(model.pins.first(where: { $0.identity.lowercased() == "alamofire" }), "SwiftPackageManager経由でAlamofireがインストールされていません")
            isAlamofireVersionMatched = alamofirePin.state.version == "5.4.3"
        case 3:
            let model = try JSONDecoder().decode(SwiftPMv3.self, from: data)
            let alamofirePin = try XCTUnwrap(model.pins.first(where: { $0.identity.lowercased() == "alamofire" }), "SwiftPackageManager経由でAlamofireがインストールされていません")
            isAlamofireVersionMatched = alamofirePin.state.version == "5.4.3"
        default:
            XCTFail("現在対応していないSwiftPackageManagerバージョンです。運営による修正対応をお待ち下さい")
        }
        
        guard let isAlamofireVersionMatched = isAlamofireVersionMatched else { return }

        XCTAssertTrue(isAlamofireVersionMatched, "Alamofireのバージョンが指定したバージョンと異なっています")
    }
    
    func testStation14() throws {
        let window = UIWindow()
        let vc = try XCTUnwrap(loadInitialViewController(in: window) as? FirstViewController, "StoryboardのInitialViewControllerが設定されていません")
        let tableView = try XCTUnwrap(vc.view.subviews.first(where: { $0 is UITableView }) as? UITableView, "UITableViewが作成されていません")
        
        let reuseIdentifier = "reuseCell"
        let cell = try XCTUnwrap(tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? BookCell, "reuseIdentifierを指定したBookCellが設定されていません")
        XCTAssertEqual(cell.reuseIdentifier, reuseIdentifier, "reuseIdentifierが指定したものと異なっています")
        
        XCTAssertNotNil(cell.contentView.subviews.first(where: { $0 is UIImageView}) as? UIImageView, "BookCellにUIImageViewが設定されていません")
        var labels = try XCTUnwrap(cell.contentView.subviews.filter({ $0 is UILabel}), "BookCellにUILabelが設定されていません")
        XCTAssertEqual(labels.count, 2, "ラベルが指定された数と異なっています")
        
        // 各ラベルの位置から判別
        labels = labels.sorted { $0.frame.origin.y < $1.frame.origin.y }
        let titleLabel = labels[0] as! UILabel
        let detailLabel = labels[1] as! UILabel
        
        XCTAssertEqual(titleLabel.numberOfLines, 1, "タイトルラベルの行数が指定された行数と異なっています")
        XCTAssertEqual(detailLabel.numberOfLines, 3, "詳細ラベルの行数が指定された行数と異なっています")
    }
    
    func testStation15() throws {
        let expectation = self.expectation(description: "test request")
        var mockBooks: [Book]!
        
        let client = BookAPIClient()
        client.fetchBooks(offset: 0) { books in
            mockBooks = books
            expectation.fulfill()
        }
        waitForExpectations(timeout: 60)

        mockBooks = try XCTUnwrap(mockBooks, "Book配列のcompletionHandlerが返ってきていません")
        XCTAssertEqual(mockBooks.count, 10, "通信で取得したデータとBook配列の要素数が異なっています")
    }
    
    func testStation16() throws {
        let window = UIWindow()
        let vc = try XCTUnwrap(loadInitialViewController(in: window) as? FirstViewController, "StoryboardのInitialViewControllerが設定されていません")
        let tableView = try XCTUnwrap(vc.view.subviews.first(where: { $0 is UITableView }) as? UITableView, "UITableViewが作成されていません")
        let data = """
            [
                {
                    "id": "hgoeidlogaMaVsL6k9Bdda",
                    "title": "Kubernetes完全ガイド 第2版 impress top gearシリーズ ",
                    "url": "https://www.amazon.co.jp/dp/B08FZX8PYW/ref=cm_sw_em_r_mt_dp_7NDC2QCY40JYYR6RE3KJ",
                    "detail": "Kubernetes解説書の決定版がついに改訂！\\n\\n        Kubernetesはコンテナ化されたアプリケーションのデプロイ、スケーリングなどの管理を自動化する「コンテナオーケストレーションエンジン」です。「クラウドネイティブ」を実現するためのコア技術として、現在多くのシステムでの利用が進んでいます。\\n\\n        本書では、アプリケーション開発者やインフラエンジニアを対象に、Kubernetesの機能やそのエコシステムについて網羅的に解説します。好評をいただいた前版を全面的に見直し、バージョン1.18に対応しました（アルファ機能を含む）。前版以降に追加された機能や変更点にも言及し、最新のKubernetesを活用するための多くの知見を提供します。",
                    "review": "めちゃくちゃわかりやすかった！",
                    "reviewer": "テストユーザ1"
                }
            ]
        """.data(using: .utf8)!
        let expectation = self.expectation(description: "mock request")
        
        XCTAssertNoThrow(try JSONDecoder().decode([Book].self, from: data), "適切なプロパティが設定されていません")
        let decodedBooks = try! JSONDecoder().decode([Book].self, from: data)
        var mockBooks: [Book]!
        
        let client = MockBookAPIClient(books: decodedBooks)
        client.fetchBooks(offset: 0) { books in
            mockBooks = books
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        vc.books = mockBooks
        tableView.reloadData()
        
        let books = try XCTUnwrap(vc.books, "booksに値が入っていません")
        XCTAssertEqual(books.count, 1)
        
        let cells = try XCTUnwrap(tableView.visibleCells.filter({ $0 is BookCell }), "BookCellが設定されていません")
        XCTAssertEqual(cells.count, 1, "通信で取得したBookデータと画面に表示するBookデータの数が異なっています")
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
        tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
        
        let secondVC = try XCTUnwrap(vc.presentedViewController, "遷移先のViewControllerが設定されていません")
        XCTAssertTrue(secondVC is SecondViewController, "遷移先のViewControllerがSecondViewControllerとして設定されていません")
        
        let webView = try XCTUnwrap(secondVC.view as? WKWebView, "遷移先のviewにWKWebViewが設定されていません")
        XCTAssertEqual(webView.url?.absoluteString, "https://www.amazon.co.jp/dp/B08FZX8PYW/ref=cm_sw_em_r_mt_dp_7NDC2QCY40JYYR6RE3KJ", "SecondViewControllerのurlに適切な値が設定されていません")
    }
    
    // MARK: station17は面談
}

extension XCTestCase {
    func loadInitialViewController(in window: UIWindow? = nil) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateInitialViewController()

        if let window = window {
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
        }

        rootViewController?.loadViewIfNeeded()
        return rootViewController
    }
}

extension UIButton {
    func tap() {
        sendActions(for: .touchUpInside)
        RunLoop.current.run(until: Date())
    }
}

struct State: Decodable {
    let branch: String?
    let revision: String
    let version: String
}

struct SwiftPMv1: Decodable {
    let object: Object
    let version: Int
    
    struct Object: Decodable {
        let pins: [Pin]
    }
    
    struct Pin: Decodable {
        let package: String
        let repositoryURL: String
        let state: State
    }
}

struct SwiftPMv2: Decodable {
    let pins: [Pin]
    let version: Int
    
    struct Pin: Decodable {
        let identity: String
        let kind: String
        let location: String
        let state: State
    }
}
struct SwiftPMv3: Decodable {
    let pins: [Pin]
    let version: Int
    let originHash: String
    
    struct Pin: Decodable {
        let identity: String
        let kind: String
        let location: String
        let state: State
    }
}

class MockBookAPIClient: BookAPIClientProtocol {
    var books: [Book]
    
    init(books: [Book]) {
        self.books = books
    }
    
    func fetchBooks(offset: Int, completion: @escaping ([Book]?) -> Void) {
        completion(books)
    }
}
