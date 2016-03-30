public class PopUpExtension{
    public Account account{get;set;}
 
    public PopUpExtension(ApexPages.StandardController stdController){
        this.account = (Account)stdCOntroller.getRecord();
    }
     
    public void saveAccount() {
        try{
            update Account;
        }catch(exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error Occured while updating the account '+e.getMessage());
            ApexPages.addMessage(myMsg);
        }
    }
}