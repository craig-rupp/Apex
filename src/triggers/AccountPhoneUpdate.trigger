trigger AccountPhoneUpdate on Account (before update) {

	for(Account acct : Trigger.new){
		if(acct.Phone != null){
			List<Contact> contacts = [SELECT Id, MailingCountry
										FROM Contact
										WHERE AccountId = :acct.Id];
			for(Contact iC : contacts){
				if(iC.MailingCountry != null && iC.MailingCountry == acct.BillingCountry){
					iC.OtherPhone = acct.Phone;
				}
			}
			update contacts;
		}
	}
}