@isTest
public class TestRestrictContactByName {

@isTest static void TestINVALIDNAMERestrictContactByName ()
{
Contact con = new Contact(FirstName='Alex',
						  LastName='INVALIDNAME');
insert con;
System.assertEquals(con.LastName,'The Last Name ');
}
@isTest static void TestRestrictContactByName ()
{
Contact con = new Contact(FirstName='Alex',
						  LastName='Lorax');
insert con;
System.assertEquals(con.LastName,'Normal Last Name ');
}
}