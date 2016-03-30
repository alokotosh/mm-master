public class wrapperClassController {

    //Our collection of the class/wrapper objects cContact 
    public List<cContact> contactList {get; set;}

    //This method uses a simple SOQL query to return a List of Contacts
    public List<cContact> getContacts() {
        if(contactList == null) {
            contactList = new List<cContact>();
            for(Opportunity c: [select Id, Name from Opportunity ]) {
                // As each contact is processed we create a new cContact object and add it to the contactList
                contactList.add(new cContact(c));
            }
        }
        return contactList;
    }


    public PageReference processSelected() 
    {
        try
        {

                //We create a new list of Contacts that we be populated only with Contacts if they are selected
        List<Opportunity > selectedContacts = new List<Opportunity >();

        //We will cycle through our list of cContacts and will check to see if the selected property is set to true, if it is we add the Contact to the selectedContacts list
        for(cContact cCon: getContacts()) {
            if(cCon.selected == true) {
                selectedContacts.add(cCon.con);
            }
        }

        // Now we have our list of selected contacts and can perform any type of logic we want, sending emails, updating a field on the Contact, etc
        
 
        for(Opportunity con: selectedContacts) 
        {
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Submitted for approval. Please approve.');
            req.setObjectId(con.Id);
            // submit the approval request for processing
            Approval.ProcessResult result = Approval.process(req);
            // display if the reqeust was successful
            System.debug('Submitted for approval successfully: '+result.isSuccess());
        }


        }
        catch(Exception ex)
        {}
                PageReference pageRef = new PageReference('/');
        pageRef.setRedirect(true);
                return pageRef;
    }


    // This is our wrapper/container class. A container class is a class, a data structure, or an abstract data type whose instances are collections of other objects. In this example a wrapper class contains both the standard salesforce object Contact and a Boolean value
    public class cContact {
        public Opportunity con {get; set;}
        public Boolean selected {get; set;}

        //This is the contructor method. When we create a new cContact object we pass a Contact that is set to the con property. We also set the selected value to false
        public cContact(Opportunity c) {
            con = c;
            selected = false;
        }
    }
}