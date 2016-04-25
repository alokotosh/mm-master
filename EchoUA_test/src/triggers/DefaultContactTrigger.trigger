trigger DefaultContactTrigger on Account (before insert, before update) {

Map<Id,Contact> insertCont = new Map<Id,Contact>();
Integer mark =0;

if (Trigger.isInsert) 
{
	for (Account a : Trigger.new) 
	{
		insertCont.put(a.id, new Contact(LastName='Default', AccountId=a.id));
	}
  insert insertCont.values();
}        
    else if (Trigger.isUpdate)
    {
    	Map<Id,Contact> defaultContacts = new Map<Id,Contact>();
   		// Make a List of Account IDs
   		List <ID> accountIDList = new List <ID> ();

		  for (Account a : [Select ID, Name From Account Where ID IN :Trigger.new]) {
		      accountIDList.add(a.ID);
		  }        
		List<Contact> cont = new List<Contact>();
		  for(Id aId :accountIDList)
		  {
		     for(Contact c: [Select ID, Name  From Contact  Where AccountId  =:aId  order by AccountId])
		     {
		     	cont.add(c);
		     }
			     if(cont.size()!=0)
			     {
			     	for(Contact c: cont)
			     	{
			     		if(c.Name=='Default') {mark++;}
			     	}
					     	if(mark==0)
					     		{
					     			defaultContacts.put(aId, new Contact(LastName='Default', AccountId=aid));		
					     		}
			     	cont = new List<Contact>();
			 	 }
			 	 else {
			 	 	defaultContacts.put(aId, new Contact(LastName='Default',AccountId=aid));
			 	 }
		  }
		System.debug(defaultContacts);
			insert defaultContacts.values();
	}
}