/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/20/2016
    @Purpose: This is the order object for CreateHMOrder api
*/
global class HM_Order{
        public HM_Account buyerAccount;
        public HM_Account billToAccount;
        public HM_Account shipToAccount;
        public HM_Address shippingAddress;
        public HM_Address billingAddress;
        public Decimal totalPrice;
        public String transactionId;
        public DateTime purchaseDateTime;
        public List<HM_OrderLine> lines;
        public Boolean isShipToSameAsBillTo;
        public Boolean isBillToSameAsBuyer;
    }