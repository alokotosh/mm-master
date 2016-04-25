public class ProcessInstanceController {
    public String processId;
    public String leadId;
    public ProcessInstance objProcessInstance;
    public Employee_Skills__c objLead {get; set;}
    public PageReference redirectPage;
    public ProcessInstanceController(){
        processId = ApexPages.currentPage().getParameters().get('id');
        leadId = ApexPages.currentPage().getParameters().get('leadId');
        objLead = [select Name from Employee_Skills__c where id =:leadId];
        redirectPage = new PageReference('/'+leadId);
    }
   
    public PageReference Approve(){
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
       // req.setComments(objLead.Comments__c);
        req.setAction('Approve');
        req.setWorkitemId(processId);
        Approval.ProcessResult result =  Approval.process(req);
        update objLead;
        return redirectPage ;
    }
   
    public PageReference Reject(){
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        //req.setComments(objLead.Comments__c);
        req.setAction('Reject');
        req.setWorkitemId(processId);
        Approval.ProcessResult result =  Approval.process(req);
        update objLead;
        return redirectPage ;      
    }
   
     public PageReference Cancel(){
     return redirectPage ;
    }
}