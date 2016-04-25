public with sharing class AccountHandler {
	public AccountHandler() {
		
	}
public static Account insertNewAccount(String name)
{
	try{
		Account ac = new Account(
			Name=name
			);
	
         

insert ac;
    return ac;

	}
	catch(DmlException e)
	{
		return null;
	}
	




}

}