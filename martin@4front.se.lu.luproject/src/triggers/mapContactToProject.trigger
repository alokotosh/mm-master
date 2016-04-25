trigger mapContactToProject on Contact (before insert) {

	for(Contact con : Trigger.new) {

		Related_Accounts__c ra = new Related_Accounts__c();
		//ra.Contact__c = con.
	}
}