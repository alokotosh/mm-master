/*
    Copyright (c) osf-global.com
    All rights reserved.
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:
    1. Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
    3. The name of the author may not be used to endorse or promote products
       derived from this software without specific prior written permission.
    
    THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
    IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
    OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
    IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, 
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
    NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
    THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/**
 * Author : Andrew Lokotosh
 * ClassName : DisplayApprovedRecordsController
 * Description : This class generates the customized view of Approval Process 
 *               History.
 **/

public class DisplayApprovedRecordsController {



    public List<SelectOption> actionList {get;set;}
    public String selectedAction {get;set;}
    
    public List<ApprovalWrapper> ApprovalProcessList {get;set;}//list to store all approval process
    public String selectedApprovalProcess{get;set;}
    Public list<ProcessInstance> recordList{get;set;} //list to store processInstance records to display on UI
     
 
    public List<selectoption> getApprovalWrapperList(){
        List<selectoption> temp=new List<selectoption>();
        temp.add(new selectoption('','--Select--'));
        for(String ap:approvalMap.keyset()){
            temp.add(new selectoption(ap,ap));
        }
        return temp;
    }
    public DisplayApprovedRecordsController (){
        ApprovalProcessList=new List<ApprovalWrapper>();
        recordList=new list<ProcessInstance> ();

        actionList = new List<SelectOption>();
        actionList.add(new SelectOption('','--None--'));
        actionList.add(new SelectOption('Approve','Approve'));
        actionList.add(new SelectOption('Reject','Reject'));
        


    }
    public map<String,ApprovalWrapper> approvalMap=new map<String,ApprovalWrapper>();

    public void FetchAllApprovalProcess(){      
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        String domainUrl=URL.getSalesforceBaseUrl().toExternalForm();
        system.debug('********domainUrl:'+domainUrl);
        String endpointUrl=domainUrl+'/services/data/v30.0/process/approvals/';
        req.setEndpoint(endpointUrl);
        req.setMethod('GET');      
        Http h = new Http();
        HttpResponse res = h.send(req);
        system.debug(res.getBody());
        String ss=res.getBody();
        string newjsondata = ss.replace('"object"','"objectName"');
       
        // Parse entire JSON response.
        JSONParser parser = JSON.createParser(newjsondata );
        while (parser.nextToken() != null) {
            // Start at the array of invoices.
            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (parser.nextToken() != null) {
                    // Advance to the start object marker to
                    //  find next approval process object.
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        // Read entire  approval process object
                        ApprovalWrapper apr= (ApprovalWrapper)parser.readValueAs(ApprovalWrapper.class);
                        system.debug('Approval name: ' + apr.name);
                        system.debug('Id: ' + apr.id);
                        ApprovalProcessList.add(apr);
                        // Skip the child start array and start object markers.
                        parser.skipChildren();
                    }
                }
            }
        }
        system.debug('********ApprovalProcessList:'+ApprovalProcessList);
        for(ApprovalWrapper aw:ApprovalProcessList){
            approvalMap.put(aw.name,aw);
        }
 }
 public Pagereference FindRecords(){
  recordList=new list<ProcessInstance> ();
        if(selectedApprovalProcess!=null && selectedApprovalProcess!=''){
            recordList=new list<ProcessInstance> ();
            String queryString='Select Id, TargetObjectId,TargetObject.name, Status From ProcessInstance Limit 10000';
            System.debug('*********queryString:'+queryString);
            List<ProcessInstance> temp=Database.query(queryString);
            ApprovalWrapper aw=new ApprovalWrapper();
            aw=approvalMap.get(selectedApprovalProcess);
            String ObjName=aw.objectName;
            recordList=new List<Processinstance>();
            For(ProcessInstance sb:temp){
                String ObjectName=String.valueof(sb.TargetObjectId.getSObjectType());
                system.debug('****ObjectName:'+ObjectName);
                if(Objectname.equalsignorecase(ObjName)){
                    recordList.add(sb);
                }
            }
            System.debug('*********recordList:'+recordList);
       }
        return null;
    }  

public Pagereference UpdateData()
            {

             return null;       
            }

            /*
    * This method will Approve the opportunity
    */
    //public void approveRecord(Employee_Skills__c eskills)
    //{
    //    Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
    //    req.setComments('Approving request using Trigger');
    //    req.setAction('Approve');
    //    //req.setNextApproverIds(new Id[] {eskills.Next_Approver__c});
    //    Id workItemId = getWorkItemId(eskills.id); 

    //    if(workItemId == null)
    //    {
    //        opp.addError('Error Occured in Apex class DisplayApprovedRecordsController: line 149');
    //    }
    //    else
    //    {
    //        req.setWorkitemId(workItemId);
    //        // Submit the request for approval
    //        Approval.ProcessResult result =  Approval.process(req);
    //    }

    //}

    // public void rejectRecord(Employee_Skills__c eskills)
    //{
    //    Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
    //    req.setComments('Rejected request using Trigger');
    //    req.setAction('Reject');
    //    //req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
    //    Id workItemId = getWorkItemId(eskills.id); 

    //    if(workItemId == null)
    //    {
    //        opp.addError('Error Occured in Apex class DisplayApprovedRecordsController: line 170');
    //    }
    //    else
    //    {
    //        req.setWorkitemId(workItemId);
    //        // Submit the request for approval
    //        Approval.ProcessResult result =  Approval.process(req);
    //    }
    //}   
    

    public class ApprovalWrapper{

        public String description{get;set;}
        public String id{get;set;}
        public String name{get;set;}
        public String objectName{get;set;}
        public Integer sortOrder{get;set;}
    }
}