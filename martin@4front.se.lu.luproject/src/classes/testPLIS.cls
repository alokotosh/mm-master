public class testPLIS {

	public Map<Integer, List<Integer>> myMap {
				get {
								return new Map<Integer, List<Integer>>{
																1 => new List<Integer>{0, 0,1,2,4,5},
																2 => new List<Integer>{1,0,2,5,3,7}
																};
				}
}

public String[] getPhase()
			{
				//return  new String[]{'Start','Pending','Closed','Contact','Idea','Verification','Development','Com','Lic'};
					return  new String[]{'1','2','3','4','5','6','7','8','9','10','11','12'};
					//return  new String[]{'January','February','March','April','May','June','July','August','September','October','November','December',''};
			}

			public String[] getMonth()
						{
							return  new String[]{'0','2','3','4','5','6','7','8','9','10','11','12'};

						}
  


//public Map<Integer,List<Integer>> dataToPhase = new Map<Integer,List<Integer>>();

// public Map<Integer,Map<Integer,Account>> getAllPhase()
// {
// 	for(Account acc: [Select  Contact_Start_Date__c,
// 																												Idea_Start_Date__c,
// 																												Verification_Start_Date__c,
// 																												Development_Start_Date__c,
// 																												Commercial_Start_Date__c,
// 																												License_Start_Date__c,
// 																												Active_Start_Date__c,
// 																												External_Proceeding_Start__c,
// 																												Pending_Start_Date__c,
// 																												Closed_Start_Date__c,
// 																												Project_Phase__c,
// 																												Project_Status__c
// 																					FROM Account])
//
//
//
// 	{
//
// 	}
//
//
// 	return dataToPhase;
// }
//
// Map<Integer, List<Account>> aphase = new Map<Integer, List<Account>>();
//
// public Map<Integer, List<Account>> getActivePhase()
// {
// aphase = [SELECT Active_Start_Date__c WHERE];
//
// 	return aphase;
// }
//

List<AggregateResult>   results =
    new List<AggregateResult >();
List<AggregateResult> cresults =
    new List<AggregateResult >([SELECT  CALENDAR_MONTH(Pending_Start_Date__c) month, Count(id) acc

                                      FROM Account WHERE CALENDAR_YEAR(Pending_Start_Date__c)=2016
									Group by CALENDAR_MONTH(Pending_Start_Date__c)
                                     ]);



   				map<Integer,Integer> active_S = new  map<Integer,Integer> ();
		 		map<Integer,Integer> pending_S = new map<Integer,Integer>();
				map<Integer,Integer> closed_S = new map<Integer,Integer>();
				map<Integer,Integer> contact_P = new map<Integer,Integer>();
				map<Integer,Integer> idea_P = new map<Integer,Integer>();
				map<Integer,Integer> verif_p = new map<Integer,Integer>();
				map<Integer,Integer> dev_p = new map<Integer,Integer>();
				map<Integer,Integer> comer_p = new map<Integer,Integer>();
				map<Integer,Integer> licen_p = new map<Integer,Integer>();

				map<Integer,Integer> active_F = new  map<Integer,Integer> ();
		 		map<Integer,Integer> pending_F = new map<Integer,Integer>();
				map<Integer,Integer> closed_F = new map<Integer,Integer>();
				map<Integer,Integer> contact_F = new map<Integer,Integer>();
				map<Integer,Integer> idea_F = new map<Integer,Integer>();
				map<Integer,Integer> verif_F = new map<Integer,Integer>();
				map<Integer,Integer> dev_F = new map<Integer,Integer>();
				map<Integer,Integer> comer_F = new map<Integer,Integer>();
				map<Integer,Integer> licen_F = new map<Integer,Integer>();
	// List< map<Integer,Integer>> listAll {get{ return	new List< map<Integer,Integer>>{getActiveStatus(),getPendingStatus()};}
	// 																																				set;}

public 	List< map<Integer,Integer>> getlistAll()
{
	return	new List< map<Integer,Integer>>{getActiveStatus(),
																																								getPendingStatus(),
																																								getClosedStatus(),
																																							getContactPhase(),
																																							getIdeaPhase(),
																																							getVerificPhase(),
																																							getDevelopmentPhase(),
																																							getComercialPhase(),
																																							getLicensePhase()
																																						};

}


public map<Integer,Integer> getActiveStatus()
{
    for(AggregateResult ar : [SELECT CALENDAR_MONTH(Active_Start_Date__c) month, Count(id) acc
                                      FROM Account WHERE CALENDAR_YEAR(Active_Start_Date__c)=2016
																																						Group by CALENDAR_MONTH(Active_Start_Date__c)
                                      ])
				{
        active_S.put((Integer)ar.get('month'), (Integer)ar.get('acc'));
    }
    for(Integer ind=1; ind<13; ind++){if(!active_S.containsKey(ind)){active_S.put(ind, 0);}}

				return active_S;
}

public map<Integer,Integer> getPendingStatus()
{
	
    for(AggregateResult ar : [SELECT CALENDAR_MONTH(Pending_Start_Date__c) month, Count(id) acc
                                      FROM Account WHERE CALENDAR_YEAR(Pending_Start_Date__c)=2016
																																						Group by CALENDAR_MONTH(Pending_Start_Date__c)
                                      ])
				{
        pending_S.put((Integer)ar.get('month'), (Integer)ar.get('acc'));
								
    }
for(Integer ind=1; ind<13; ind++){if(!pending_S.containsKey(ind)){pending_S.put(ind, 0);}}
			
				return pending_S;
}


public map<Integer,Integer> getClosedStatus()
{
    for(AggregateResult ar : [SELECT CALENDAR_MONTH(Closed_Start_Date__c) month, Count(id) acc
                                      FROM Account WHERE CALENDAR_YEAR(Closed_Start_Date__c)=2016
																																						Group by CALENDAR_MONTH(Closed_Start_Date__c)

                                      ])
				{
        closed_S.put((Integer)ar.get('month'), (Integer)ar.get('acc'));
    }
    				for(Integer ind=1; ind<13; ind++){if(!closed_S.containsKey(ind)){closed_S.put(ind, 0);}}
				return closed_S;
}

public map<Integer,Integer> getContactPhase()
{
    for(AggregateResult ar : [SELECT CALENDAR_MONTH(Contact_Start_Date__c) month, Count(id) acc
                                      FROM Account WHERE CALENDAR_YEAR(Contact_Start_Date__c)=2016
																																						Group by CALENDAR_MONTH(Contact_Start_Date__c)
                                      ])
				{
        contact_P.put((Integer)ar.get('month'), (Integer)ar.get('acc'));
    }
    for(Integer ind=1; ind<13; ind++){if(!contact_P.containsKey(ind)){contact_P.put(ind, 0);}}

				return contact_P;
}

public map<Integer,Integer> getIdeaPhase()
{
    for(AggregateResult ar : [SELECT CALENDAR_MONTH(Idea_Start_Date__c) month, Count(id) acc
                                      FROM Account WHERE CALENDAR_YEAR(Idea_Start_Date__c)=2016
																																						Group by CALENDAR_MONTH(Idea_Start_Date__c)
                                      ])
				{
        idea_P.put((Integer)ar.get('month'), (Integer)ar.get('acc'));
    }
    	for(Integer ind=1; ind<13; ind++){if(!idea_P.containsKey(ind)){idea_P.put(ind, 0);}}

				return idea_P;
}

public map<Integer,Integer> getVerificPhase()
{
    for(AggregateResult ar : [SELECT CALENDAR_MONTH(Verification_Start_Date__c) month, Count(id) acc
                                      FROM Account WHERE CALENDAR_YEAR(Verification_Start_Date__c)=2016
																																						Group by CALENDAR_MONTH(Verification_Start_Date__c)
                                      ])
				{
        verif_p.put((Integer)ar.get('month'), (Integer)ar.get('acc'));
    }
    for(Integer ind=1; ind<13; ind++){if(!verif_p.containsKey(ind)){verif_p.put(ind, 0);}}

				return verif_p;
}

public map<Integer,Integer> getDevelopmentPhase()
{
    for(AggregateResult ar : [SELECT CALENDAR_MONTH(Development_Start_Date__c) month, Count(id) acc
                                      FROM Account WHERE CALENDAR_YEAR(Development_Start_Date__c)=2016
																																						Group by CALENDAR_MONTH(Development_Start_Date__c)
                                      ])
				{
        dev_p.put((Integer)ar.get('month'), (Integer)ar.get('acc'));
    }

    for(Integer ind=1; ind<13; ind++){if(!dev_p.containsKey(ind)){dev_p.put(ind, 0);}}

				return dev_p;
}

public map<Integer,Integer> getComercialPhase()
{
    for(AggregateResult ar : [SELECT CALENDAR_MONTH(Commercial_Start_Date__c) month, Count(id) acc
                                      FROM Account WHERE CALENDAR_YEAR(Commercial_Start_Date__c)=2016
																																						Group by CALENDAR_MONTH(Commercial_Start_Date__c)
                                      ])
				{
        comer_p.put((Integer)ar.get('month'), (Integer)ar.get('acc'));
    }

    for(Integer ind=1; ind<13; ind++){if(!comer_p.containsKey(ind)){comer_p.put(ind, 0);}}

				return comer_p;
}

public map<Integer,Integer> getLicensePhase()
{
    for(AggregateResult ar : [SELECT CALENDAR_MONTH(License_Start_Date__c) month, Count(id) acc
                                      FROM Account WHERE CALENDAR_YEAR(License_Start_Date__c)=2016
																																						Group by CALENDAR_MONTH(License_Start_Date__c)
                                      ])
				{
        licen_p.put((Integer)ar.get('month'), (Integer)ar.get('acc'));
    }
    for(Integer ind=1; ind<13; ind++){if(!licen_p.containsKey(ind)){licen_p.put(ind, 0);}}

				return licen_p;
}



}