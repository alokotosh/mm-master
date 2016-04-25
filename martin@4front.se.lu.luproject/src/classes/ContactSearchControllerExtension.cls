public with sharing class ContactSearchControllerExtension
{
    private final Contact ctt;

    public ContactSearchControllerExtension(ApexPages.StandardController stdController)
    {
        this.ctt = (Contact)stdController.getRecord();
    }
    //Properties
    public Contact[] results
    {
        get
        {
            if(results == null) results = new Contact[0];
            return results;
        }
        set {results = value;}
    }

    public Boolean hasSearched
    {
        get
        {
            if(hasSearched == null) hasSearched = false;
            return hasSearched;
        }
        set {hasSearched = value;}
    }

    public Boolean resultsFound
    {
        get
        {
            if(results.size() == 0)
                return false;
            else
                return true;
        }
    }

    public Boolean lastNameStartsWith
    {
        get
        {
            if(lastNameStartsWith == null) lastNameStartsWith = true;
            return lastNameStartsWith;
        }
        set {lastNameStartsWith = value;}
    }

    public Boolean firstNameStartsWith
    {
        get
        {
            if(firstNameStartsWith == null) firstNameStartsWith = true;
            return firstNameStartsWith;
        }
        set {firstNameStartsWith = value;}
    }

    public Boolean emailStartsWith
    {
        get
        {
            if(emailStartsWith == null) emailStartsWith = true;
            return emailStartsWith;
        }
        set {emailStartsWith = value;}
    }

    public String contactEmail
    {
        get
        {
            if(contactEmail == null) contactEmail = '';
            return contactEmail;
        }
        set {contactEmail = value;}
    }
    //Actions
    public PageReference searchContacts()
    {
        results.clear();
        hasSearched = true;

        //Validation rules
        if(ctt.LastName != null && ctt.LastName.length() == 1)
        {
            ctt.LastName.addError('Använd minst två tecken och försök igen');
            hasSearched = false;
            return null;
        }
        if(ctt.FirstName != null && ctt.FirstName.length() == 1)
        {
            ctt.FirstName.addError('Använd minst två tecken och försök igen');
            hasSearched = false;
            return null;
        }
        //Validation rules passsed, continue
        //Prepare SOQL Query
        String soqlQuery = 'select Id, Name, Email, AccountId, Account.Name, OwnerId, Owner.Name from Contact where Id != null ';
        if(ctt.LastName != null)
        {
            if(lastNameStartsWith)
                soqlQuery += 'and LastName like \'' + ctt.LastName.replace('\'', '\\\'') + '%\' ';
            else
                soqlQuery += 'and LastName like \'%' + ctt.LastName.replace('\'', '\\\'') + '%\' ';
        }
        if(ctt.FirstName != null)
        {
            if(firstNameStartsWith)
                soqlQuery += 'and FirstName like \'' + ctt.FirstName.replace('\'', '\\\'') + '%\' ';
            else
                soqlQuery += 'and FirstName like \'%' + ctt.FirstName.replace('\'', '\\\'') + '%\' ';
        }
        if(contactEmail.length() > 0)
        {
            if(emailStartsWith)
                soqlQuery += 'and Email like \'' + contactEmail.replace('\'', '\\\'') + '%\' ';
            else
                soqlQuery += 'and Email like \'%' + contactEmail.replace('\'', '\\\'') + '%\' ';
        }

        soqlQuery += 'order by Name limit 1000';

        results = Database.query(soqlQuery);

        if (results.size() == 0)
            ctt.LastName.addError('Inga kontakter kunde hittas. Ändra din sökning och försök igen.');

        return null;
    }

    public PageReference newContact()
    {
        String recordType = ApexPages.currentPage().getParameters().get('RecordType');
        String retURL = ApexPages.currentPage().getParameters().get('retURL');
        String saveURL = ApexPages.currentPage().getParameters().get('saveURL');
        String accid = ApexPages.currentPage().getParameters().get('accid');

        String url = '/003/e?nooverride=1';
        url += recordType == null? '' : '&RecordType=' + EncodingUtil.urlEncode(recordType, 'UTF-8');
        url += accid == null ? '' : '&accid=' + EncodingUtil.urlEncode(accid, 'UTF-8');
        url += retURL == null ? '' : '&retURL=' + EncodingUtil.urlEncode(retURL, 'UTF-8');
        url += saveURL == null ? '' : '&saveURL=' + EncodingUtil.urlEncode(saveURL, 'UTF-8');
        url += ctt.LastName == null ? '' : '&name_lastcon2=' + EncodingUtil.urlEncode(ctt.LastName, 'UTF-8');
        url += ctt.FirstName == null ? '' : '&name_firstcon2=' + EncodingUtil.urlEncode(ctt.FirstName, 'UTF-8');
        url += contactEmail == '' ? '' : '&con15=' + EncodingUtil.urlEncode(contactEmail, 'UTF-8');

        PageReference newContactPage = new PageReference(url);
        newContactPage.setRedirect(true);
        return newContactPage;
    }
   }