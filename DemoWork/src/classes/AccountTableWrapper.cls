public with sharing class AccountTableWrapper {
	public List<Account> accs {get; set;}
	public List<RowWrapper> rows {get; set;}
		public List<HeaderWrapper> head {get; set;}
	public AccountTableWrapper() {

	}

	public List<Account> getAccounts()
{
    if (null==accs)
    {
        accs=[select id, Name, BillingStreet, BillingCity, BillingPostalCode from Account
              where BillingCity != null and BillingPostalCode!=null limit 3];
    }

    return accs;
}

// retrieves the list of row wrappers
public List<RowWrapper> getRowWrappers()
{
    if (null==rows)
    {
        rows=new List<RowWrapper>();

        // create a row for each field - there are 4 of these, Name, Street, City and PostCode
        for (Integer idx=0; idx<3; idx++)
        {
            rows.add(new RowWrapper());
        }

        // iterate the accounts and populate the rows
        for (Integer idx=0; idx<getAccouns().size(); idx++)
        {

            rows[0].addValue(getAccounts()[idx].BillingStreet);
            rows[1].addValue(getAccounts()[idx].BillingCity);
            rows[2].addValue(getAccounts()[idx].BillingPostalCode);
        }
    }

    return rows;
}
public List<RowWrapper> getHeaderWrappers()
{
    if (null==head)
    {
        head=new List<HeaderWrapper>();

        // create a row for each field - there are 4 of these, Name, Street, City and PostCode
        for (Integer idx=0; idx<4; idx++)
        {
            head.add(new HeaderWrapper());
        }

        // iterate the accounts and populate the rows
        for (Integer idx=0; idx<getAccounts().size(); idx++)
        {
            rows[0].addValue(getAccounts()[idx].Name);
        }
    }

    return rows;
}


public class RowWrapper
			{
				// the values (cells) making up this row
				public List<String> values {get; set;}
				Data da ='2015/11/11';

				// constructor
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
