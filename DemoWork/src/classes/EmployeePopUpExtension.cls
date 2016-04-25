public with sharing class EmployeePopUpExtension {
	public Employee__c empl {get;set;}
	ApexPages.StandardController stdController;

	public EmployeePopUpExtension (ApexPages.StandardController stdController) {
    empl = (Employee__c) stdController.getRecord();
  }
	//public void save() {
 //       try{
 //           update employee;
 //       }catch(exception e) {
 //           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error Occured while updating the account '+e.getMessage());
 //           ApexPages.addMessage(myMsg);
 //       }
 //   }
}