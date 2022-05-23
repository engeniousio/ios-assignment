@testable import engenious_challenge
import XCTest

final class RepositoryCombineServiceTest: XCTestCase {
    
    private var service: RepositoryServiceProtocol!
    private var urlService: URLServiceMock!
    
    override func setUp() {
        super.setUp()
        
        urlService = URLServiceMock()
        service = RepositoryCombineService(urlService: urlService)
    }
    
    func testGetUserRepos() {
        service.getUserRepos(username: "", completion: { _ in })
        XCTAssert(urlService.makeRequestPublisherInvoked)
    }
}
