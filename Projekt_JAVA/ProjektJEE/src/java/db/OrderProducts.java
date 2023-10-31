package db;

import java.io.Serializable;


public class OrderProducts implements Serializable{
    
    private int idSeller;
    private int orderStatus;
    private boolean buyerRead;
    private boolean sellerRead;
    private boolean adminRead;
    private String problemDescription;
    private Product productt;
    
    public int getIdSeller() 
    {
        return idSeller;
    }

    public void setIdSeller(int idSeller) 
    {
        this.idSeller = idSeller;
    }

    public String getOrderStatus() 
    {
        switch (this.orderStatus) 
        {
            case 1:
                return "Zwrot kosztow";
            case 2:
                return "Raport negatywny";
            case 3:
                return "Odrzucony";
            case 5:
                return "Płatnosc otrzymana";
            case 6:
                return "Zamowienie w przygotowaniu";
            case 7:
                return "Zamowienie wyslane";
            case 8:
                return "Zamowienie zrealizowane";
            case 9:
                return "Anomalia zgłoszona do sklepu i do administratora";
            default:
                return "Brak informacji";
            
          
        }
    }
    
    public int getOrderStatusNumber() {
        switch (this.orderStatus) {
            case 1:
                return 1;
            case 2:
                return 2;
            case 3:
                return 3;
            case 5:
                return 5;
            case 6:
                return 6;
            case 7:
                return 7;
            case 8:
                return 8;
            case 9:
                return 9;
            default:
                return 0;
        }
    }
    
    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }

    public boolean isBuyerRead() {
        return buyerRead;
    }

    public void setBuyerRead(boolean buyerRead) {
        this.buyerRead = buyerRead;
    }

    public boolean isSellerRead() {
        return sellerRead;
    }

    public void setSellerRead(boolean sellerRead) {
        this.sellerRead = sellerRead;
    }

    public boolean getAdminRead() {
        return adminRead;
    }

    public void setAdminRead(boolean adminRead) {
        this.adminRead = adminRead;
    }

    public String getProblemDescription() {
        return problemDescription;
    }

    public void setProblemDescription(String problemDescription) {
        this.problemDescription = problemDescription;
    }

    public Product getProductt() {
        return productt;
    }

    public void setProductt(Product productt) {
        this.productt = productt;
    }

}
