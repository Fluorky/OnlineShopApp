package db;

import java.io.Serializable;
import java.util.ArrayList;
import java.lang.Math;

public class Product implements Serializable 
{
    
    private int id;    
    private String name;    
    private String description;    
    private double price;    
    private int id_shop;      
    private int instock;    
    private String categoria;    
    private Shop shop;    
    private float avg_rate=0;    
    private int num_reviews;     
    private ArrayList<Review> Reviews = new ArrayList<Review>();    
    private ArrayList<Photo> Photos = new ArrayList<Photo>();    
    private ArrayList<UsersPhoto> UsersPhotos = new ArrayList<UsersPhoto>();   
    private int quantity=1; 
    

    public String getcategoria() 
    {
        return categoria;
    }

    public void setcategoria(String categoria) 
    {
        this.categoria = categoria;
    }
    
    public int getId() 
    {
        return id;
    }

    public void setId(int id) 
    {
        this.id = id;
    }

    public String getName() 
    {
        return name;
    }

    public void setName(String name) 
    {
        this.name = name;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public double getPrice() 
    {
        return price;
    }

    public void setPrice(double price) 
    {
        this.price = price;
    }

    public int getId_shop() 
    {
        return id_shop;
    }

  
    public void setId_shop(int id_shop) 
    {
        this.id_shop = id_shop;
    }
    
    public int getInStock() 
    {
        return instock;
    }
    
    public void setInStock(int instock) 
    {
        this.instock = instock;
    }
  
    public void setShop(Shop shop) 
    {
        this.shop = shop;
    }
    
  
    public Shop getShop() 
    {
        return shop;
    }

    public int getNum_reviews() 
    {
        return num_reviews;
    }

    
    public void setNum_reviews(int num_reviews) 
    {
        this.num_reviews = num_reviews;
    }

    public ArrayList<Review> getReviews() 
    {
        return Reviews;
    }

    public void setReviews(Review r) 
    {
        Reviews.add(r);
    }

    public ArrayList<Photo> getPhotos() 
    {
        return Photos;
    }

    public void addPhoto(Photo p) 
    {
        this.Photos.add(p);
    }
    
    public ArrayList<UsersPhoto> getUsersPhotos() 
    {
        return UsersPhotos;
    }

    public void addUsersPhoto(UsersPhoto p) 
    {
        this.UsersPhotos.add(p);
    }
    
    public int getAvg_rate() 
    {
        if (this.Reviews.isEmpty())
        {
            return 0;
        }
        return (int) Math.round(avg_rate);
    }

    public void setAvg_rate() 
    {
        for (Review r: this.Reviews )
        {
                avg_rate+= r.getRate();
        }
        
        this.avg_rate = (avg_rate/(this.Reviews.size()));
    }

    public int getQuantity() 
    {
        return quantity;
    }

    public void addQuantity() 
    {
        this.quantity = this.quantity+1;
    }
    
     public void setQuantity(int quantity) 
    {
        this.quantity= quantity;
    }
    
    public void subtractQuantity() 
    {
        this.quantity = this.quantity-1;
    }
    
    
}

