trigger WarrantySummary on Case (before insert) {
	for (Case myCase : Trigger.new){
		if(myCase.Product_Purchase_Date__c != null && 
		   myCase.Product_Has_Extended_Warranty__c != null && 
		   myCase.Product_Total_Warranty_Days__c != null){
			String purchaseDate = myCase.Product_Purchase_Date__c.format();
			String createdDate = DateTime.now().format(); //with before trigger, system saved values have not been set and must then be set with o
			Integer warrantyDays = myCase.Product_Total_Warranty_Days__c.intValue();
			Decimal warrantyPercentage = (100 * (myCase.Product_Purchase_Date__c.daysBetween(Date.today()) / myCase.Product_Total_Warranty_Days__c)).setScale(2);
			//Decimal warrantyPercentage = (Date.today() - createdDate) / warrantyDays;
			Boolean extendedWarranty = myCase.Product_Has_Extended_Warranty__c;

			//Populate Summary string with fields set on trigger above
			myCase.Warranty_Summary__c = 'Product purchased on ' + purchaseDate 
									   + ' and case created on ' + createdDate + '.\n'
									   + 'Warranty is for ' + warrantyDays + ' days and is : ' + warrantyPercentage + ', through it\'s warranty period.\n'
									   + 'The Extended warranty is: ' + extendedWarranty + '.\n'
									   + 'Have a Nice Day!'; 
		}
	}
	/*
	Product purchased on <<Purchase Date>> and case created on <Case Created Date>
	Warranty is for <<Warranty Total Days>> days and is <Warranty Percentage> through its warranty period
	Extended warranty: <Has Extended Warranty>
	Have a Nice Day!
	*/
}