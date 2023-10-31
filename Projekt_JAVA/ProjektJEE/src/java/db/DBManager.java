package db;

import HTML.HTMLFilter;
import java.util.ArrayList;
import java.util.List;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBManager implements Serializable
{

 
    private transient Connection CON;

   
    public DBManager(String dbUrl) throws SQLException
    {
        try
        {
            System.out.println("Loading driver...");
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("Driver loaded!");
        }
        catch (ClassNotFoundException cnfe)
        {
            throw new RuntimeException(cnfe.getMessage(), cnfe.getCause());
        }

        CON = DriverManager.getConnection(dbUrl);
    }

  
    public boolean newUser(String email, String firstName, String lastName, String password) throws SQLException 
    {

        try (PreparedStatement stm = CON.prepareStatement("INSERT INTO USERS (email, firstName, lastName, role, password) VALUES (?, ?, ?, 'user', ?)")) 
        {
            try
            {
                stm.setString(1, email);
                stm.setString(2, firstName);
                stm.setString(3, lastName);
                stm.setString(4, password);
                stm.executeUpdate();
            }
            catch (java.sql.SQLIntegrityConstraintViolationException ex)
            {
                return true;
            }
        }
        return false;
    }

    
    public User autenticazione(String email, String password) throws SQLException 
    {
        User user = new User();
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM USERS WHERE email = ? AND password = ?")) 
        {

            stm.setString(1, email);
            stm.setString(2, password);

            try (ResultSet rs = stm.executeQuery())
            {

                if (rs.next())
                {

                    user.setId(rs.getInt("id"));
                    user.setEmail(email);
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastName"));
                    user.setRole(rs.getString("role"));
                    user.setPassword(password);

                } 
                else 
                {
                    return null;
                }
            }
        }
        setUserNotifications(user);
        return user;
    }

 
    public Shop getShop(int id) throws SQLException
    {
        Shop s = new Shop();
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM SHOPS WHERE id= ?"))
        {
            stm.setInt(1, id);
            try (ResultSet rs = stm.executeQuery())
            {
                if (rs.next())
                {
                    s.setId(rs.getInt("id"));
                    s.setName(rs.getString("name"));
                    s.setDescription(rs.getString("description"));
                    s.setWeb_Site_Url(rs.getString("web_Site_Url"));
                    s.setAddress(rs.getString("address"));
                    s.setRate(rs.getInt("rate"));
                    s.setId_Owner(rs.getInt("id_Owner"));
                    s.setId_Creator(rs.getInt("id_Creator"));
                }
            }
        }
        return s;
    }

     public Shop getShopOwner(int id) throws SQLException
    {
        Shop s = new Shop();
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM SHOPS WHERE id_Owner= ?"))
        {
            stm.setInt(1, id);
            try (ResultSet rs = stm.executeQuery())
            {
                if (rs.next())
                {
                    s.setId(rs.getInt("id"));
                    s.setName(rs.getString("name"));
                    s.setDescription(rs.getString("description"));
                    s.setWeb_Site_Url(rs.getString("web_Site_Url"));
                    s.setAddress(rs.getString("address"));
                    s.setRate(rs.getInt("rate"));
                    s.setId_Owner(rs.getInt("id_Owner"));
                    s.setId_Creator(rs.getInt("id_Creator"));
                }
            }
        }
        return s;
    }

    

    public List<Product> getProducts(String nazwaProduktu, String categoria, User user) throws SQLException
    {
        String append = ""; 
        if (!"".equals(nazwaProduktu) && categoria.equals("Wszystkie kategorie"))
        {
            append = " AND p.name LIKE \"" + "%" + nazwaProduktu + "%" + "\""; 
        }
        else if ("".equals(nazwaProduktu) && (!categoria.equals("Wszystkie kategorie"))) 
        {
            append = " AND p.categoria=\"" + categoria + "\""; 
        } 
        else if (!"".equals(nazwaProduktu) && !categoria.equals("Wszystkie kategorie"))
        {
            append = " AND p.name LIKE \"" + "%" + nazwaProduktu + "%" + "\" AND p.categoria=\"" + categoria + "\"";
        }
        
        ArrayList<Product> products = new ArrayList<>();
       
        try (PreparedStatement stm = CON.prepareStatement("SELECT  p.*, s.name as shop_name, s.description as shop_description, s.web_Site_Url, s.address, s.rate, s.id_Owner, s.id_Creator FROM PRODUCTS p, SHOPS s WHERE  p.id_shop=s.id" + append + " ORDER BY p.price"))
        {

            try (ResultSet rs = stm.executeQuery())
            {

                while (rs.next()) 
                {
                    Product p = new Product();
                    Shop s = new Shop();
                    
                    p.setId(rs.getInt("id"));
                    p.setName(HTMLFilter.filter(rs.getString("name")));
                    p.setDescription(HTMLFilter.filter(rs.getString("description")));
                    p.setPrice(rs.getDouble("price"));             
                    p.setId_shop(rs.getInt("id_shop"));
                    p.setcategoria(rs.getString("categoria"));
                    p.setInStock(rs.getInt("InStock"));
                    s.setId(rs.getInt("id_shop"));
                    s.setName(rs.getString("shop_name"));
                    s.setDescription(rs.getString("shop_description"));
                    s.setWeb_Site_Url(rs.getString("web_Site_Url"));
                    s.setAddress(rs.getString("address"));
                    s.setRate(rs.getInt("rate"));
                    s.setId_Owner(rs.getInt("id_Owner"));
                    s.setId_Creator(rs.getInt("id_Creator"));
                    p.setShop(s);
                    
                    if (user == null)
                    {
                        products.add(p);
                    }
                    else if (user.getId() != s.getId_Owner())
                    {
                        products.add(p);
                    }
                }
            }
        }

        for (Product p : products)
        { 
            try (PreparedStatement stm1 = CON.prepareStatement("SELECT r.* , DATE_ADD(r.date_creation , INTERVAL + 2 HOUR) as italy_date FROM REVIEWS r, PRODUCTS p  WHERE p.id = ? AND p.id = r.id_product ORDER BY italy_date DESC")) 
            {
                stm1.setInt(1, p.getId());

                try (ResultSet rs1 = stm1.executeQuery())
                {
                    while (rs1.next())
                    {
                        Review r = new Review();
                        
                        r.setId(rs1.getInt("id"));
                        r.setRate(rs1.getInt("rate"));
                        r.setName_Author(rs1.getString("name"));
                        r.setDescription(HTMLFilter.filter(rs1.getString("description")));
                        r.setDate(rs1.getString("italy_date").split(" ")[0]);
                        r.setId_product(rs1.getInt("id_product"));
                        r.setId_Creator(rs1.getInt("id_creator"));
                        p.setReviews(r); 
                        p.setNum_reviews(p.getReviews().size()); 
                    }
                }
            }
            p.setAvg_rate(); 

            try (PreparedStatement stm2 = CON.prepareStatement("SELECT pi.* FROM PICTURES pi, PRODUCTS p WHERE p.id = ? AND p.id = pi.id_Product"))
            {
                stm2.setInt(1, p.getId());

                try (ResultSet rs2 = stm2.executeQuery())
                {
                    while (rs2.next())
                    {
                        Photo ph = new Photo();
                        ph.setId(rs2.getInt("id"));
                        ph.setName(rs2.getString("name"));
                        ph.setId_Product(rs2.getInt("id_Product"));
                        ph.setId_Owner(rs2.getInt("id_Owner"));
                        p.addPhoto(ph);
                    }
                }
            }

            try (PreparedStatement stm2 = CON.prepareStatement("SELECT pi.* FROM USERS_PICTURES pi, PRODUCTS p WHERE p.id = ? AND p.id = pi.id_Product")) 
            {
                stm2.setInt(1, p.getId());

                try (ResultSet rs2 = stm2.executeQuery())
                {
                    while (rs2.next())
                    {
                        UsersPhoto ph = new UsersPhoto();
                        
                        ph.setId(rs2.getInt("id"));
                        ph.setName(rs2.getString("name"));
                        ph.setId_Product(rs2.getInt("id_Product"));
                        ph.setId_Owner(rs2.getInt("id_Owner"));
                        ph.setNameOwner(rs2.getString("nameOwner"));
                        p.addUsersPhoto(ph);
                    }
                }
            }
        }
        return products;
    }


    public ArrayList<Order> getOrders(User user) throws SQLException
    {
        ArrayList<Order> orders = new ArrayList<>();
        String append = "";
        switch (user.getRole())
        {
            case "registered":
                append = " WHERE idBuyer = ? ";
                break;
            case "salesperson":
                append = " WHERE idBuyer = ? ";
                break;
        }
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM ORDERS " + append + "ORDER BY DATE DESC"))
        {
            if (!user.getRole().equals("admin"))
            {
                stm.setInt(1, user.getId());
            }

            try (ResultSet rs = stm.executeQuery())
            {
                while (rs.next())
                {
                    Order o = new Order();
                    
                    o.setId(rs.getInt("id"));
                    o.setIdBuyer(rs.getInt("idBuyer"));
                    o.setBuyerName(rs.getString("buyerName"));
                    o.setDate(rs.getString("date").split(" ")[0]);
                    orders.add(o);
                }
            }
        }

        for (Order o : orders)
        { 
            try (PreparedStatement stm1 = CON.prepareStatement("SELECT p.id, p.name, p.price, p.InStock, op.quantity, s.name as shop_name, s.id_Owner as seller_id, op.buyerReadNot, op.sellerReadNot, op.adminReadNot, op.problemDescription, op.orderStatus FROM ORDER_PRODUCTS op INNER JOIN PRODUCTS p ON op.productid = p.id INNER JOIN ORDERS o ON o.id=op.orderid INNER JOIN SHOPS s ON p.id_shop=s.id WHERE o.id = ?"))
            {
                stm1.setInt(1, o.getId());

                try (ResultSet rs1 = stm1.executeQuery()) 
                {
                    while (rs1.next()) 
                    {
                        Product p = new Product();
                        Shop s = new Shop();
                        OrderProducts op = new OrderProducts();
                        
                        p.setId(rs1.getInt("id"));
                        p.setName(HTMLFilter.filter(rs1.getString("name")));
                        p.setPrice(rs1.getDouble("price"));
                        p.setInStock(rs1.getInt("InStock"));
                        p.setQuantity(rs1.getInt("quantity"));
                        s.setName(rs1.getString("shop_name"));
                        s.setId_Owner(rs1.getInt("seller_id"));
                        op.setBuyerRead(rs1.getBoolean("buyerReadNot"));
                        op.setSellerRead(rs1.getBoolean("sellerReadNot"));
                        op.setAdminRead(rs1.getBoolean("adminReadNot"));
                        op.setOrderStatus(rs1.getInt("orderStatus"));
                        op.setProblemDescription(rs1.getString("problemDescription"));
                        
                        p.setShop(s);
                        op.setProductt(p);
                        o.addOrderDetails(op);
                    }
                }
            }
        }
        return orders;
    }


    public ArrayList<Order> getOrdersSeller(User user) throws SQLException 
    {
        ArrayList<Order> orders = new ArrayList<>();

        try (PreparedStatement stm = CON.prepareStatement("SELECT DISTINCT o.id, o.idBuyer, o.buyerName, o.date FROM ORDERS o, ORDER_PRODUCTS op, SHOPS s, PRODUCTS p WHERE op.orderid=o.id AND s.id_Owner= ? AND p.id=op.productid ORDER BY DATE DESC"))
        {
            stm.setInt(1, user.getId());

            try (ResultSet rs = stm.executeQuery())
            {
                while (rs.next())
                {
                    Order o = new Order();
                    
                    o.setId(rs.getInt("id"));
                    o.setIdBuyer(rs.getInt("idBuyer"));
                    o.setBuyerName(rs.getString("buyerName"));
                    o.setDate(rs.getString("date").split(" ")[0]);
                    
                    orders.add(o);
                }
            }
        }

        for (Order o : orders)
        { 
            try (PreparedStatement stm1 = CON.prepareStatement("SELECT p.id, p.name, p.price,p.InStock, op.quantity, s.name as shop_name, s.id_Owner as seller_id, op.buyerReadNot, op.sellerReadNot, op.adminReadNot, op.problemDescription, op.orderStatus FROM ORDER_PRODUCTS op INNER JOIN PRODUCTS p ON op.productid = p.id INNER JOIN ORDERS o ON o.id=op.orderid INNER JOIN SHOPS s ON p.id_shop=s.id WHERE o.id = ?"))
            {
                stm1.setInt(1, o.getId());

                try (ResultSet rs1 = stm1.executeQuery())
                {
                    while (rs1.next()) 
                    {
                        if (user.getId() == rs1.getInt("seller_id")) 
                        {
                            Product p = new Product();
                            Shop s = new Shop();
                            OrderProducts op = new OrderProducts();
                            
                            p.setId(rs1.getInt("id"));
                            p.setName(HTMLFilter.filter(rs1.getString("name")));
                            p.setPrice(rs1.getDouble("price"));
                            p.setInStock(rs1.getInt("InStock"));
                            p.setQuantity(rs1.getInt("quantity"));
                            s.setName(rs1.getString("shop_name"));
                            s.setId_Owner(rs1.getInt("seller_id"));
                            op.setBuyerRead(rs1.getBoolean("buyerReadNot"));
                            op.setSellerRead(rs1.getBoolean("sellerReadNot"));
                            op.setAdminRead(rs1.getBoolean("adminReadNot"));
                            op.setOrderStatus(rs1.getInt("orderStatus"));
                            op.setProblemDescription(rs1.getString("problemDescription"));
                            
                            p.setShop(s);
                            op.setProductt(p);
                            o.addOrderDetails(op);
                        }
                    }
                }
            }
        }
        return orders;
    }

    public boolean newOrder(int id, String userName, ArrayList<Product> previousItems) throws SQLException
    {
        int lastOrderNumber = 0;

        try (PreparedStatement stm = CON.prepareStatement("INSERT INTO ORDERS (idBuyer, buyerName) VALUES (?, ? )"))
        {
            try
            {

                stm.setInt(1, id);
                stm.setString(2, userName);
                stm.executeUpdate();
            }
            catch (java.sql.SQLIntegrityConstraintViolationException ex)
            {
                return false;
            }
        }

        try (PreparedStatement stm = CON.prepareStatement("SELECT id FROM ORDERS ORDER BY DATE DESC")) 
        {
            try (ResultSet rs = stm.executeQuery())
            {
                if (rs.next()) 
                {
                    lastOrderNumber = rs.getInt("id");
                }
            }
        }

        for (Product p : previousItems) 
        {
            try (PreparedStatement stm = CON.prepareStatement("INSERT INTO ORDER_PRODUCTS  (orderid, productid, quantity) VALUES (?, ?, ? )")) 
            {
                try 
                {
                    if (lastOrderNumber != 0) 
                    {
                        stm.setInt(1, lastOrderNumber);
                        stm.setInt(2, p.getId());
                        stm.setInt(3, p.getQuantity());
                        stm.executeUpdate();
                    } 
                    else 
                    {
                        return false;
                    }
                } 
                catch (java.sql.SQLIntegrityConstraintViolationException ex) 
                {
                    return false;
                }
            }
        }
        return true;
    }

    public void setUserNotifications(User user) throws SQLException 
    {
        String role = user.getRole();
        String append = "";
        
        switch (role) 
        {
            case "registered":
                append = "idBuyer";
                break;
            case "salesperson":
                append = "idSeller";
                break;
            case "admin":
                append = "admin";
                break;
        }

        if (role.equals("registered") || role.equals("salesperson")) 
        { 
            try (PreparedStatement stm = CON.prepareStatement("SELECT op.buyerReadNot FROM ORDER_PRODUCTS op INNER JOIN ORDERS o ON o.id=op.orderid WHERE o.idBuyer=? AND buyerReadNot=0")) 
            {
                stm.setInt(1, user.getId());

                try (ResultSet rs = stm.executeQuery()) 
                {
                    while (rs.next()) 
                    {
                        user.setNum_notifies();
                    }
                }
            }
        }
        if (role.equals("salesperson")) 
        { 
            try (PreparedStatement stm = CON.prepareStatement("SELECT  op.sellerReadNot FROM ORDER_PRODUCTS op INNER JOIN PRODUCTS p ON op.productid = p.id INNER JOIN ORDERS o ON o.id=op.orderid INNER JOIN SHOPS s ON p.id_shop=s.id WHERE s.id_Owner=? AND op.sellerReadNot=0")) 
            {
                stm.setInt(1, user.getId());

                try (ResultSet rs = stm.executeQuery()) 
                {
                    while (rs.next()) 
                    {
                        user.setNum_notifies();
                    }
                }
            }
        }

    }

    public void InvioAnomaly(int orderStatus, String problemDescription, int orderid, int productid) throws SQLException 
    {

        try (PreparedStatement stm = CON.prepareStatement("UPDATE ORDER_PRODUCTS SET buyerReadNot=1, sellerReadNot=0, adminReadNot=0, orderStatus=?, problemDescription = ? WHERE orderid=? AND productid=?")) 
        {
            try 
            {

                stm.setInt(1, orderStatus);
                stm.setString(2, problemDescription);
                stm.setInt(3, orderid);
                stm.setInt(4, productid);
                stm.executeUpdate();
            } 
            catch (SQLException e) 
            {
                System.err.println(e.getMessage());
            }
        }

    }

    public void menageAnomaly(int orderStatus, int orderid, int productid) throws SQLException 
    {

        try (PreparedStatement stm = CON.prepareStatement("UPDATE ORDER_PRODUCTS SET buyerReadNot=0, sellerReadNot=0, adminReadNot=1, orderStatus=?, problemDescription=? WHERE orderid=? AND productid=?")) 
        {
            try 
            {

                stm.setInt(1, orderStatus);
                stm.setString(2, "Problemem zajal sie administrator");
                stm.setInt(3, orderid);
                stm.setInt(4, productid);
                stm.executeUpdate();
            } 
            catch (SQLException e) 
            {
                System.err.println(e.getMessage());
            }
        }

        if (orderStatus == 2) 
        {
            int rateShop = 0;
            int shopid = 0;
            try (PreparedStatement stm = CON.prepareStatement("SELECT s.rate, s.id FROM SHOPS s, PRODUCTS p WHERE p.id= ? AND p.id_shop= s.id")) 
            {
                stm.setInt(1, productid);
                try (ResultSet rs = stm.executeQuery()) 
                {
                    if (rs.next()) 
                    {
                        rateShop = rs.getInt("rate");
                        shopid = rs.getInt("id");
                    }
                } 
                catch (SQLException e)
                {
                    System.err.println(e.getMessage());
                }
            }
            if (rateShop != 0 && shopid != 0) 
            {
                try (PreparedStatement stm = CON.prepareStatement("UPDATE SHOPS SET rate= ? WHERE id= ? ")) 
                {
                    try 
                    {
                        stm.setInt(1, (rateShop - 1));
                        stm.setInt(2, shopid);
                        stm.executeUpdate();
                    } 
                    catch (SQLException e) 
                    {
                        System.err.println(e.getMessage());
                    }
                }
            }
        }
    }

    public boolean addPhoto(int idProduct, String name, int id_Owner, String nameUser) throws SQLException 
    {

        try (PreparedStatement stm = CON.prepareStatement("INSERT INTO USERS_PICTURES (`name`, `id_Product`, `id_Owner`, `nameOwner`) VALUES (?, ?, ?, ?)")) 
        {
            try 
            {
                stm.setString(1, name);
                stm.setInt(2, idProduct);
                stm.setInt(3, id_Owner);
                stm.setString(4, nameUser);
                stm.executeUpdate();
            } 
            catch (SQLException ex) 
            {
                System.out.println(ex);
                return false;
            }
        }
        return true;
    }
}
