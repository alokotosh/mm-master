public with sharing class FindAllProducts {
	public FindAllProducts() {
		
	}

	public List<Product2> getAllProducts()
	{
		return [select Id, Description from Product2 Where Description LIKE '%a%' ];			
	}
		

	public  Map<Id,Product2> createPricebook()
	{
		Pricebook2 pbook = new Pricebook2(Name= 'HICPricebook', 
									      IsActive = true );
        Map<Id,Product2> pp = new Map<Id,Product2>();  // Pricebook2 to Product
        insert pbook;

        Pricebook2 standardpb = [select id from pricebook2 where isstandard = true Limit 1];

        List<Product2> prod = new List<Product2>();
    	List<PricebookEntry> entryStandard =  new List<PricebookEntry>();
    	List<PricebookEntry> entryPbook =  new List<PricebookEntry>();
        for(Integer idx=0; idx<10;idx++)
        { 
        	prod.add(new Product2(Name='testProd'+idx));
         }
        	insert prod;
        for (Product2 p :prod)
        	{  
        		entryStandard.add(new PricebookEntry( Product2Id = p.id,
       										  Pricebook2Id = standardpb.id,
        									  UnitPrice = 1000,
        									  IsActive = true));
        	 }
        	 insert entryStandard;
       	for (Product2 p :prod)
        	{  
        		entryPbook.add(new PricebookEntry( Product2Id = p.id,
       										  Pricebook2Id = pbook.id,
        									  UnitPrice = 1000,
        									  IsActive = true));
            

        	 }
        	 insert entryPbook;
             return pp;
	}

}