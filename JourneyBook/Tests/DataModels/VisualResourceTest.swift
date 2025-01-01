import Testing
import Foundation

@testable import JourneyBook


struct VisualResourceTest {
    
    @Test
    func testInitialization() {
        let sampleData = Data([0x00, 0x01, 0x02])
        let resource = VisualResource(resourceData: sampleData, resourceType: .image, aidDescription: "Test Description")
        
        #expect(resource.id != UUID())
        #expect(resource.resourceData == sampleData)
        #expect(resource.resourceType == .image)
        #expect(resource.aidDescription == "Test Description")
        // #expect(resource.steps.isEmpty)  MARK: RENABLE ONCE STEPS BROUGH BACK!
    }
  
}
