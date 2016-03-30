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
/**

* File: EmployeeSkillsListController.cls<br/>

* Project: Developer Project <br/>

* Date: Creation Date (e.g.: January 10, 2016)<br/>

* Created By: Andrew Lokotosh <br/>

* *************************************************************************<br/>

* Description: This class using for return List of Employee Skills and sort It. <br/>

* *************************************************************************<br/>

* History: Used for any changes added to the class after first release.<br/>

* Date(same format as above) - Developer Name - what method was modified, what are the changes<br/>

*/

public with sharing class EmployeeSkillsListController {
	 private String sortOrder = 'CreatedDate';

    /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method return List of Employee Skills
    *
    * @return List of Employee Skills
    *
    **/

	public List<Employee_Skills__c> getEmployeeSkills() 
    {
        List<Employee_Skills__c>   results = Database.query(
                    'SELECT  Id,Name,CreatedDate, Employee__c, Employee_Email__c,Status__c,Grade__c, Project__c ' +
                    'FROM Employee_Skills__c ' +
                    'ORDER BY ' + sortOrder + ' ASC '+
                    'Limit'+' 10000' );
        return results;
}

    /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method change sortOrder to CreatedDate
    *
    **/
    public void sortByCreatedDate() {
        this.sortOrder = 'CreatedDate';
    }
     /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method change sortOrder to Name
    *
    **/
        
    public void sortByName() {
        this.sortOrder = 'Name';
    }
     /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method change sortOrder to Employee_Email__c
    *
    **/
    public void sortByEmail() {
        this.sortOrder = 'Employee_Email__c';
    }
     /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method change sortOrder to Project__c
    *
    **/    
    public void sortByProject() {
        this.sortOrder = 'Project__c';
    }
     /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method change sortOrder to Employee__c
    *
    **/
    public void sortByEmployee() {
        this.sortOrder = 'Employee__c';
    }
      /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method change sortOrder to Status__c
    *
    **/   
    public void sortByStatus() {
        this.sortOrder = 'Status__c';
    }
     /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method change sortOrder to Grade__c
    *
    **/
    public void sortByGrade() {
        this.sortOrder = 'Grade__c';
    }
		
	
}