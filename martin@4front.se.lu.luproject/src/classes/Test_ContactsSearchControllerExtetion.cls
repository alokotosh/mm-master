@isTest
public  class Test_ContactsSearchControllerExtetion {
	//Test method
	public static testmethod void testController_Extension()
	{
					Test.setCurrentPageReference(Page.ContactsSearch);
					Contact testContact = new Contact();
					ApexPages.StandardController sc = new ApexPages.StandardController(testContact);

					Test.startTest();

					//ControllerExtension csce = new ControllerExtension(sc);
					ContactSearchControllerExtension csce = new ContactSearchControllerExtension(sc);

					//Test properties
					csce.hasSearched = null;
					Boolean hasSearched = csce.hasSearched;
					System.assert(!hasSearched);
					csce.hasSearched = true;
					hasSearched = csce.hasSearched;
					System.assert(hasSearched);

					Contact[] contactArray = new Contact[0];
					contactArray.add(new Contact());
					contactArray.add(new Contact());
					csce.results = contactArray;
					System.assertEquals(contactArray, csce.results);
					System.assertEquals(2, csce.results.size());
					csce.results = null;
					System.assertNotEquals(null, csce.results);

					csce.lastNameStartsWith = null;
					Boolean lastNameStartsWith = csce.lastNameStartsWith;
					System.assert(lastNameStartsWith);
					csce.lastNameStartsWith = false;
					lastNameStartsWith = csce.lastNameStartsWith;
					System.assert(!lastNameStartsWith);

					csce.firstNameStartsWith = null;
					Boolean firstNameStartsWith = csce.firstNameStartsWith;
					System.assert(firstNameStartsWith);
					csce.firstNameStartsWith = false;
					firstNameStartsWith = csce.firstNameStartsWith;
					System.assert(!firstNameStartsWith);

					csce.emailStartsWith = null;
					Boolean emailStartsWith = csce.emailStartsWith;
					System.assert(emailStartsWith);
					csce.emailStartsWith = false;
					emailStartsWith = csce.emailStartsWith;
					System.assert(!emailStartsWith);

					String testContactEmail = csce.contactEmail;
					System.assertEquals('', testContactEmail);
					testContactEmail = 'testContactEmail';
					csce.contactEmail = testContactEmail;
					System.assertEquals('testContactEmail', csce.contactEmail);

					//Test validation rules
					csce.ctt.LastName = '1';
					PageReference searchPage = csce.searchContacts();
					System.assertEquals(null, searchPage);
					csce.ctt.LastName = '';
					csce.ctt.FirstName = '1';
					searchPage = csce.searchContacts();
					System.assertEquals(null, searchPage);

					//Test search with all search criteria blank
					csce.ctt.LastName = '';
					csce.ctt.FirstName = '';
					csce.contactEmail = '';
					searchPage = csce.searchContacts();
					System.assertEquals(null, searchPage);

					//Test search with all set to starts with search
					csce.ctt.LastName = 'test';
					csce.ctt.FirstName = 'test';
					csce.contactEmail = 'test';
					csce.lastNameStartsWith = true;
					csce.firstNameStartsWith = true;
					csce.emailStartsWith = true;
					searchPage = csce.searchContacts();
					System.assertEquals(null, searchPage);

					//Test search with all set to contains search
					csce.lastNameStartsWith = false;
					csce.firstNameStartsWith = false;
					csce.emailStartsWith = false;
					searchPage = csce.searchContacts();
					System.assertEquals(null, searchPage);

					//Test search with zero results
					csce.ctt.LastName = 'aasdfadssdfsfasdf';
					searchPage = csce.searchContacts();
					System.assertEquals(null, searchPage);
					System.assert(!csce.resultsFound);

					//Test search with one result
					testContact = new Contact(LastName='test', FirstName='test', Email='test@test.test');
					insert testContact;
					csce.ctt.LastName = 'test';
					csce.ctt.FirstName = 'test';
					csce.contactEmail = 'test@test.test';
					searchPage = csce.searchContacts();
					System.assertEquals(null, searchPage);
					System.assert(csce.resultsFound);

					//Test newContact no query params
					csce.ctt.LastName = null;
					csce.ctt.FirstName = null;
					csce.contactEmail = null;
					String newPageUrl = csce.newContact().getUrl();
					System.assert(newPageUrl.contains('/003/e'));
					System.assert(newPageUrl.contains('nooverride=1'));
					System.assert(!newPageUrl.contains('RecordType=123'));
					System.assert(!newPageUrl.contains('accid=123'));
					System.assert(!newPageUrl.contains('retURL=123'));
					System.assert(!newPageUrl.contains('name_lastcon2'));
					System.assert(!newPageUrl.contains('name_firstcon2'));
					System.assert(!newPageUrl.contains('con15'));

					//Test newContact with query params
					csce.ctt.LastName = 'test';
					csce.ctt.FirstName = 'test';
					csce.contactEmail = 'test@test.test';
					PageReference testPageReference = new PageReference(Page.ContactsSearch.getUrl() + '?RecordType=123&accid=123&retURL=123');
					Test.setCurrentPageReference(testPageReference);
					newPageUrl = csce.newContact().getUrl();
					System.assert(newPageUrl.contains('/003/e'));
					System.assert(newPageUrl.contains('nooverride=1'));
					System.assert(newPageUrl.contains('RecordType=123'));
					System.assert(newPageUrl.contains('accid=123'));
					System.assert(newPageUrl.contains('retURL=123'));
					System.assert(newPageUrl.contains('name_lastcon2=test'));
					System.assert(newPageUrl.contains('name_firstcon2=test'));
					System.assert(newPageUrl.contains('con15=test'));

					Test.stopTest();
	}
}