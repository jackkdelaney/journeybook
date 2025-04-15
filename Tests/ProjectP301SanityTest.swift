import Testing

@testable import JourneyBook

struct SanityChecksTests {
    @Test func sanityCheck() {
        let calc = 2 + 2
        #expect(calc == 4)
    }

    @Test func sanityCheckExtra() {
        let check = SantityCheckExtra()

        #expect(check.checkReturn4() == 4)
    }

    @Test func sanityCheckExtraStatic() {
        #expect(SantityCheckExtra.checkReturn4Static() == 4)
    }
}
