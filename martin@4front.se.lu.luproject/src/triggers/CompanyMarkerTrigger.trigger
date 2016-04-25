trigger CompanyMarkerTrigger on Company__c (before insert) {


Map<Id,Id> ca = new Map<Id,Id>();
	for(Company__c c: Trigger.New)
	{
		ca.put(c.id, c.Project__c);
	}

}