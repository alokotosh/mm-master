/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/20/2016
    @Purpose: This is the response object for isvalidKitId api
*/
global class kitIdResponse{
        public Boolean isValid;
        public String orderProductId;
        public String orderNumber;
        public HMAPIError error;
    }