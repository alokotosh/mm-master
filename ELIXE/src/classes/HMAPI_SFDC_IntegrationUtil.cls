/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/20/2016
    @Purpose: This is the util class for generic methods that can be used by multiple APIs
*/
public with sharing class HMAPI_SFDC_IntegrationUtil {

    //create new account
     public static Id createNewAccount(HM_Account hmAccount){
        Account acc = new Account(name = hmAccount.contact.firstName+' '+hmAccount.contact.lastName);
        insert acc;
        return acc.Id;
        
    }
    
    //create new contact. this also includes creation of legal agreements for the contacts 
    public static Id createNewContact(HM_Contact hmContact, Id accId){
        
        Contact con = new Contact(firstname = hmContact.firstName, lastName = hmContact.lastName, email = hmContact.email, accountId = accId, userid__c = hmContact.userId,
                                    phone = hmContact.phone, Naturally_Black_Hair__c = hmContact.blackNaturally, Biological_Sex__c = hmContact.biologicalSex);
        insert con;
        List<Legal_Agreement__c> agreeList = new List<Legal_Agreement__c>();
        System.debug('Agreements : '+hmContact.agreements);
        if(hmContact.agreements != null){
            for(HM_Agreement mnt : hmContact.agreements){
                Legal_Agreement__c agmt = new Legal_Agreement__c();
                agmt.key__c = mnt.key;
                agmt.version__c = mnt.version;
                agmt.Contact__c = con.Id;
                agmt.agreed__c = true;
                agmt.agreedDateTime__c = System.today();
                agreeList.add(agmt);
            }
        }
        if(agreeList.size() > 0){
            insert agreeList;
        }
        return con.Id;
    }
       
    //Method called when UserId is not null
    public static Contact getExistingContact(String userId){     
        //Querying Contact with the given userId
        Contact con;
        List<Contact> conList = [ Select Id, phone,Naturally_Black_Hair__c,Biological_Sex__c, AccountId, Account.NON_BUYER_Account__c From Contact Where userid__c = :userId ];
        if(conList.size() > 0){
            con = conList[0];
        }
        if(con == null ){
          //return error
          return null;
        } else if( con != null ){
             return con;
          }
        return null;
    }
    
    
}