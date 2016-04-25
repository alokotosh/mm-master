public with sharing class ContactSearch {
	public ContactSearch() {
		
	}


	public static List<Contact> searchForContacts(String NameC, String PostageCode)
	{	
       List<Contact> cont = new List<Contact>([
       					SELECT ID,Name
                          FROM Contact 
                          WHERE LastName=:NameC 
                          AND MailingPostalCode=:PostageCode]);   



return cont;




	}
}