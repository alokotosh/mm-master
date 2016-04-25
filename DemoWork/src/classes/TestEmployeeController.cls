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

* File: TestEmployeeController.cls<br/>

* Project: Developer Project <br/>

* Date: Creation Date (e.g.: January 10, 2016)<br/>

* Created By: Andrew Lokotosh <br/>

* *************************************************************************<br/>

* Description: This class using for return List of Employee Skills and sort It. <br/>

* *************************************************************************<br/>

* History: Used for any changes added to the class after first release.<br/>

* Date(same format as above) - Developer Name - what method was modified, what are the changes<br/>

*/

@isTest public class TestEmployeeController {
    

        /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method check Map that conained Employee and List of String
    *
    **/
    @isTest static public void checkMapEmployee()
      {
       	EmployeeController con = new EmployeeController();
        Map<Employee__c,List<String>> testMap = con.getEmployee();
        System.debug('checkMapEmployee -testMap= ' + testMap); 
      }
        /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method check write  returning of Paginations methids
    *
    **/
      @isTest static public void checkPaginations()
      {
        EmployeeController con = new EmployeeController();
        PageReference nextReference = con.Next();
        System.debug('checkPaginations -nextReference='+nextReference);
        PageReference previousReference = con.Previous();
        System.debug('checkPaginations -previousReference='+previousReference);
        Integer pageNumber = con.getPageNumber();
        System.debug('checkPaginations -pageNumber='+pageNumber);
        Integer totalSize = con.getTotal_size(); 
        System.debug('checkPaginations -totalSize='+totalSize);
      }

        /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method check if Disable Previous work well
    *
    **/
     @isTest static public void checkDisablePrevious()
      {
       	EmployeeController con = new EmployeeController();
        Boolean checkPrevios = con.getDisablePrevious();
        System.debug('checkDisablePrevious -First checkPrevios='+checkPrevios);
        con.OffsetSize=20;
        checkPrevios = con.getDisablePrevious();
        System.debug('checkDisablePrevious -Second checkPrevios='+checkPrevios);
      }
        /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method check if Disable Next work well
    *
    **/
    @isTest static public void checkDisableNext()
    {
       	EmployeeController con = new EmployeeController();
        Boolean checkNext = con.getDisableNext();
        System.debug('checkDisableNext - First checkNext='+checkNext);
        con.OffsetSize=-20;
        checkNext = con.getDisableNext();
        System.debug('checkDisableNext - Second checkNext='+checkNext); 
      }
        /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method check method return properly Number of  Total Pages
    *
    **/
    @isTest static public void checkTotalPages()
    {
        EmployeeController con = new EmployeeController();
        Integer totalPages = con.getTotalPages();
        System.debug('checkTotalPages -First totalPages='+totalPages);
        con.CountTotalRecords =13;
        con.QueryLimit=12;
        totalPages = con.getTotalPages();
        System.debug('checkTotalPages -Second totalPages='+totalPages);
    }
}