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

* File: EmployeeController.cls<br/>

* Project: Developer Project <br/>

* Date: Creation Date (e.g.: January 10, 2016)<br/>

* Created By: Andrew Lokotosh <br/>

* *************************************************************************<br/>

* Description: This class using for return Map of Employee (key) and List of String(Employee Skills Name) (values).<br/>
* Also this class using for page pagination.<br/>

* *************************************************************************<br/>

* History: Used for any changes added to the class after first release.<br/>

* Date(same format as above) - Developer Name - what method was modified, what are the changes<br/>

*/



public with sharing class EmployeeController  {

    
    public Integer CountTotalRecords{get;set;}
    public Integer OffsetSize = 0;
    public Integer QueryLimit = 5; 
    private List<Employee__c>   employee = new List<Employee__c>();
    private  Map<Employee__c,List<String>> returns = new Map<Employee__c,List<String>>();
    public Employee__c empl {get;set;}
    public ApexPages.StandardController stdController;
    
    
public EmployeeController (ApexPages.StandardController stdController)
    {
        CountTotalRecords= [select count() from Employee__c];
        empl = (Employee__c) stdController.getRecord();
    }
    /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method  return Map of Employee (key) and List of String(Employee Skills Name) as (values)
    *
    * @return Map<Employee__c,List<String>>
    *
    **/
    public  Map<Employee__c,List<String>> getEmployee() {
    
        employee =   [Select id, Name, Number_Of_Skills__c,(SELECT  Id,Name, Employee__c 
                      FROM Employee_Skills__r)
                      from Employee__c 
                      order by Name
                      limit :QueryLimit 
                      offset :OffsetSize 
                      ];
                    for(Employee__c e: employee)
                    {
                        if(e.Number_Of_Skills__c==0)
                                {
                                    returns.put(e,new List<String>{'_'}); 
                                }
                                else
                                {
                                    for(Employee_Skills__c es: e.Employee_Skills__r)
                                    {
                                        if(returns.containsKey(e))
                                        {
                                             returns.get(e).add(es.Name);
                                             System.debug(e.Name +'_  '+ returns.get(e)+'_');
                                        }
                                        else
                                        {
                                            returns.put(e, new List<String>{es.Name});
                                            System.debug(e.Name +'+  '+ returns.get(e)+'+');
                                        }
                                         
                                    }
                                }   
                    }
    return returns;
}   

                                /**  Methods for Page Paginations   */
/**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method check if Previous button will be visible
    *
    * @return Boolean
    **/
    public Boolean getDisablePrevious(){
        if(OffsetSize>0)
        {
            return false;
        }
        else 
        {
            return true;
        }
    }
    /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method check if Next button will be visible
    * 
    * @return Boolean
    **/
    public Boolean getDisableNext() {
        if (OffsetSize + QueryLimit < CountTotalRecords){
            return false;
        }
        else
        {
          return true;   
        }
    }
    /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method change value of OffsetSize and gives Next page
    *
    * @return null
    **/
    public  PageReference Next() {
            returns.clear();
            OffsetSize += QueryLimit;

            return null;
    }
    /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method change value of OffsetSize and gives Previous page
    *
    * @return null
    **/
    public  PageReference Previous() {
        returns.clear();
        OffsetSize -= QueryLimit;
        return null;
    }
    /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method gives current page number
    *
    * @return Integer number
    **/
    public Integer getPageNumber() {

        return OffsetSize/QueryLimit + 1;
    }
    /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method gives total size of records
    *
    * @return Integer number
    **/
    public Integer getTotal_size() {

        return CountTotalRecords;
    }
    /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method  gives integer number of pages
    *
    * @return Integer number
    **/
    public Integer getTotalPages() {
        if (math.mod(CountTotalRecords, QueryLimit) > 0) {
            return CountTotalRecords/QueryLimit + 1;
        } else {
            return (CountTotalRecords/QueryLimit);
        }
    }














}