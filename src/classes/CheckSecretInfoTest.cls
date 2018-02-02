@isTest
private class CheckSecretInfoTest {
	
	@isTest static void checkSecretInfo() {
		// Implement test code - 1)Create Case, 2) Case Subject Can't Begin with Warning, 3) Case Description needed
		//4) Case Contain keyword
		Case testCase = new Case();
		testCase.Subject = 'Testing Secret Info Trigger';
		testCase.Description = 'Credit Card SSN';

		insert testCase;

	}	
}