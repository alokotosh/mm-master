public with sharing class DraftsToPersons {
				public List<Draft__c> draft {get; set;}
				public List<Person__c> pers {get; set;}
				public List<Time__c> tim {get; set;}
				public List<RowWrapper> rows {get; set;}

				public DraftsToPersons()
				{


				}
				public List<Draft__c> getDrafts()
			{
							if (null==draft)
							{
											draft=[select id, Name from Draft__c
																		order by Name asc
																		limit 1000];
							}

							return draft;
			}
			public List<Person__c> getPersons()
		{
						if (null==pers)
						{
										pers=[select id, Name from Person__c
																	order by Name asc
																	limit 1000];
						}
						return pers;
		}

		public List<Time__c> getTimes()
	{
					if (null==tim)
					{
									tim=[select id, Name, Person__r.id, Draft__r.id from Time__c
																limit 1000];
					}
					return tim;
	}
	public List<RowWrapper> getRowWrappers()
	{
	    if (null==rows)
	    {
	        rows=new List<RowWrapper>();

	        // create a row for each field - there are 4 of these, Name, Street, City and PostCode
	        for (Integer idx=0; idx<getDrafts().size(); idx++)
	        {
	            rows.add(new RowWrapper());
	        }

	        // iterate the accounts and populate the rows
	        for (Integer idx=0; idx<getPersons().size(); idx++)
	        {

	            rows[idx].addValue(getTimes()[idx].Name);

	        }
	    }

	    return rows;
	}



	public class RowWrapper
				{
					// the values (cells) making up this row
					public List<String> values {get; set;}


					public RowWrapper()
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