public with sharing class ContactAndLeadSearch {
	public ContactAndLeadSearch() {
		
	}

	public static List<List<sObject>> searchContactsAndLeads(String SN)
	{



List<List<sObject>> searchList = [FIND :SN IN ALL FIELDS 
                   RETURNING Contact(FirstName,LastName),Lead(FirstName,LastName)];
Contact[] searchAccounts = (Contact[])searchList[0];
Lead[] searchContacts = (Lead[])searchList[1];





 		return searchList;
	}
}