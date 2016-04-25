public class ReportPLIS_Controller {

	public List<Account> accs {get; set;}
	public List<RowWrapper> rows {get; set;}
		public List<HeaderWrapper> head {get; set;}
		public List<String> month = new List<String>{'1','2','3','4','5','6','7','8','9','10','11','12'};




	public ReportPLIS_Controller() {

	}
public List<Account> contact_a{get;set;}
public List<Integer> con = new List<Integer>();



	public List<Integer> getContacts()
	{


			Integer year =2016;
					for (Integer idx=1; idx<13; idx++)
					{
									con.add(count_contact_phase(idx,year));
					}


		return con;
	}

	public  Integer count_contact_phase (Integer month, Integer year)
	{


			contact_a= [SELECT id, Contact_Start_Date__c
																FROM Account
																WHERE CALENDAR_MONTH(Contact_Start_Date__c)=:month
																AND CALENDAR_YEAR(Contact_Start_Date__c)=:year
															];

							return contact_a.size();
	}


 public Map<Date, Map<Date,List<String>>> getProject()
	{
		// List<Account> ac = [SELECT Contact_Start_Date__c,
		// 																											Idea_Start_Date__c,
		// 																											Verification_Start_Date__c,
		// 																											Development_Start_Date__c,
		// 																											Commercial_Start_Date__c,
		// 																											License_Start_Date__c,
		// 																											Active_Start_Date__c,
		// 																											External_Proceeding_Start__c,
		// 																											Pending_Start_Date__c,
		// 																											Closed_Start_Date__c,
		// 																											Project_Phase__c,
		// 																											Project_Status__c
		// 																				FROM Account];
		// 		List<Date>
		// 		List<Account> contact_a = [    ]
  // for(Account a: ac)
		// {
		// 	if( a.Project_Phase__c=='Contact')
		// 	{
		//
		// 	}
		//
		//
		// }
		//
		//


		return null;
	}

// Map<Integer, List<Integer>> m;
// 			//Integer - list<String>


public String[] getPhase()
{
	return  new String[]{' ','Contact','Idea','Verification','Development','Com','Lic'};

}
public List<RowWrapper> getRowWrappers()
{
	Integer year =2016;
    if (null==rows)
    {
        rows=new List<RowWrapper>();

        // create a row for each field - there are 4 of these, Name, Street, City and PostCode
        for (Integer idx=0; idx<12; idx++)
        {
            rows.add(new RowWrapper());
        }

        // iterate the accounts and populate the rows
        for (Integer idx=0; idx<6; idx++)
        {

            //rows[0].addValue(getPhaseWrappers()[idx].Jenuary);
												rows[0].addValue(new PhaseWrapper(1, year));
												rows[1].addValue(new PhaseWrapper(2, year));
												//rows[2].addValue(new PhaseWrapper(3, year));
												//rows[3].addValue(new PhaseWrapper(4, year));
												//rows[4].addValue(new PhaseWrapper(5, year));
												//rows[5].addValue(new PhaseWrapper(6, year));
												//rows[6].addValue(new PhaseWrapper(7, year));
												//rows[7].addValue(new PhaseWrapper(8, year));
												//rows[8].addValue(new PhaseWrapper(9, year));
												//rows[9].addValue(new PhaseWrapper(10, year));
												//rows[10].addValue(new PhaseWrapper(11, year));
												//rows[11].addValue(new PhaseWrapper(12, year));
								//				rows[12].addValue(new PhaseWrapper(2, year);
           // rows[1].addValue(getPhaseWrapper()[idx].April);
            //rows[2].addValue(getPhaseWrapper()[idx].BillingPostalCode);
        }
    }

    return rows;
}


public class PhaseWrapper

{
//public List<Account> contact_a;
public List<Account> idea_a;
public List<Account> verific_a;
public List<Account> development_a;
public List<Account> comertcial_a;
public List<Account> license_a;

private Integer month{get;set;}
private Integer year{get;set;}

//ist<Integer> pases get;set;}

//List<Integer> contacts;
Integer ideas;
Integer verificaitons;
Integer developments;
Integer comertcial;
Integer license;

public PhaseWrapper (Integer month, Integer year)
{
					this.month = month;
					this.year = year;
				//contacts=	count_contact_phase(month,year);
				ideas=	count_idea_phase(month,year);
				verificaitons=	count_verific_phase(month,year);
				developments=	count_develop_phase(month,year);
				comertcial=	count_comercial_phase(month,year);
				license=count_license_phase(month,year);

			//	pase.add(contacts);
}

		// public  Integer count_contact_phase (Integer month, Integer year)
		// {
		//
		// 		if(null ==contact_a)
		// 						{
		// 		contact_a= [SELECT id, Contact_Start_Date__c
		// 															FROM Account
		// 															WHERE CALENDAR_MONTH(Contact_Start_Date__c)=:month
		// 															AND CALENDAR_YEAR(Contact_Start_Date__c)=:year
		// 														];
		// 						}
		// 						return contact_a.size();
		// }
		//
		// public List<Integer> getContacts(Integer year)
		// {
		//
		// 				for (Integer idx=1; idx<13; idx++)
		// 				{
		// 								contacts.add(count_contact_phase(idx,year));
		// 				}
		//
		//
		// 	return contacts;
		// }




		public  Integer count_idea_phase (Integer month, Integer year)
		{
				if(null ==idea_a)
								{
				idea_a= [SELECT id, Idea_Start_Date__c
																	FROM Account
																	WHERE CALENDAR_MONTH(Idea_Start_Date__c)=:month
																	AND CALENDAR_YEAR(Idea_Start_Date__c)=:year
																];
								}
								return idea_a.size();
		}

		public  Integer count_verific_phase (Integer month, Integer year)
		{
				if(null ==verific_a)
								{
				verific_a= [SELECT id, Verification_Start_Date__c
																	FROM Account
																	WHERE CALENDAR_MONTH(Verification_Start_Date__c)=:month
																	AND CALENDAR_YEAR(Verification_Start_Date__c)=:year
																];
								}
								return verific_a.size();
		}

		public   Integer count_develop_phase (Integer month, Integer year)
		{
				if(null ==development_a)
								{
				development_a= [SELECT id, Development_Start_Date__c
																	FROM Account
																	WHERE CALENDAR_MONTH(Development_Start_Date__c)=:month
																	AND CALENDAR_YEAR(Development_Start_Date__c)=:year
																];
								}

								return  development_a.size();

		}

		public  Integer count_comercial_phase (Integer month, Integer year)
		{
				if(null ==comertcial_a)
								{
				comertcial_a= [SELECT id, Commercial_Start_Date__c
																	FROM Account
																	WHERE CALENDAR_MONTH(Commercial_Start_Date__c)=:month
																	AND CALENDAR_YEAR(Commercial_Start_Date__c)=:year
																];

								}
								return comertcial_a.size();
		}
		public   Integer count_license_phase (Integer month, Integer year)
		{
				if(null ==license_a)
								{
				license_a=  [SELECT id, License_Start_Date__c
																	FROM Account
																	WHERE CALENDAR_MONTH(License_Start_Date__c)=:month
																	AND CALENDAR_YEAR(License_Start_Date__c)=:year
																];
								}

								return license_a.size();
		}





}

public class RowWrapper
		{
			// the values (cells) making up this row
			public List<PhaseWrapper> values {get; set;}

			// constructor
			public RowWrapper()
			{
				values=new List<PhaseWrapper>();
			}

			// append a value (cell) to the row
			public void addValue(PhaseWrapper value)
			{
				values.add(value);
			}
		}

		public class HeaderWrapper
					{
						// the values (cells) making up this row
						public List<String> values {get; set;}

						// constructor
						public HeaderWrapper()
						{
							values=new List<String>();
						}

						// append a value (cell) to the row
						public void addValue(String value)
						{
							values.add(value);
						}
					}




}