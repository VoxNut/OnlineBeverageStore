package com.beveragestore.util;

import com.beveragestore.dao.OrderDAO;
import com.beveragestore.dao.ProductDAO;
import com.beveragestore.dao.UserDAO;
import com.beveragestore.model.Order;
import com.beveragestore.model.Product;
import com.beveragestore.model.User;
import com.google.cloud.firestore.Firestore;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ExecutionException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DatabaseSeeder {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseSeeder.class);

    public static void main(String[] args) {
        logger.info("Starting Database Seeder...");

        try {
            // Force initialization of Firebase
            Firestore db = FirebaseInitializer.getInstance().getFirestore();
            logger.info("Firebase initialized successfully. Seeding data...");

            UserDAO userDAO = new UserDAO();
            ProductDAO productDAO = new ProductDAO();
            OrderDAO orderDAO = new OrderDAO();

            // 1. Seed Users
            logger.info("Seeding Users...");
            List<User> users = seedUsers(userDAO);

            // 2. Seed Products
            logger.info("Seeding Products...");
            List<Product> products = seedProducts(productDAO);

            // 3. Seed Orders
            logger.info("Seeding Orders...");
            seedOrders(orderDAO, users, products);

            logger.info("Database Seeder finished successfully!");

            // Allow background threads to finish sending
            Thread.sleep(3000);
            System.exit(0);
            
        } catch (Exception e) {
            logger.error("Error during database seeding", e);
            System.exit(1);
        }
    }

    private static List<User> seedUsers(UserDAO userDAO) throws Exception {
        List<User> seededUsers = new ArrayList<>();

        // Create default users for each role
        User admin = new User(UUID.randomUUID().toString(), "System Admin", "admin@grindery.com", 
                org.mindrot.jbcrypt.BCrypt.hashpw("admin123", org.mindrot.jbcrypt.BCrypt.gensalt()), 
                User.ROLE_ADMIN, new Date());
        
        User shopOwner = new User(UUID.randomUUID().toString(), "Shop Owner", "owner@grindery.com", 
                org.mindrot.jbcrypt.BCrypt.hashpw("owner123", org.mindrot.jbcrypt.BCrypt.gensalt()), 
                User.ROLE_SHOP_OWNER, new Date());
        
        User shipper = new User(UUID.randomUUID().toString(), "Fast Shipper", "shipper@grindery.com", 
                org.mindrot.jbcrypt.BCrypt.hashpw("shipper123", org.mindrot.jbcrypt.BCrypt.gensalt()), 
                User.ROLE_SHIPPER, new Date());
        
        User customer1 = new User(UUID.randomUUID().toString(), "Alice Customer", "alice@customer.com", 
                org.mindrot.jbcrypt.BCrypt.hashpw("customer123", org.mindrot.jbcrypt.BCrypt.gensalt()), 
                User.ROLE_CUSTOMER, new Date());

        User customer2 = new User(UUID.randomUUID().toString(), "Bob Customer", "bob@customer.com", 
                org.mindrot.jbcrypt.BCrypt.hashpw("customer123", org.mindrot.jbcrypt.BCrypt.gensalt()), 
                User.ROLE_CUSTOMER, new Date());

        List<User> usersToCreate = Arrays.asList(admin, shopOwner, shipper, customer1, customer2);
        
        for (User u : usersToCreate) {
            // Check if exists
            User existing = userDAO.findByEmail(u.getEmail());
            if (existing == null) {
                userDAO.createUser(u);
                seededUsers.add(u);
                logger.info("Created user: {}", u.getEmail());
            } else {
                seededUsers.add(existing);
                logger.info("User already exists: {}", existing.getEmail());
            }
        }
        
        return seededUsers;
    }

    private static List<Product> seedProducts(ProductDAO productDAO) throws ExecutionException, InterruptedException {
        List<Product> productsToCreate = Arrays.asList(
            new Product(UUID.randomUUID().toString(), "Ethiopia Yirgacheffe Light Roast", "Coffee", "Grindery Reserve", 
                "A bright, floral light roast with notes of jasmine and bergamot. Ethically sourced from Yirgacheffe.", 24.00, 50, 
                "https://res.cloudinary.com/dbpl94opl/image/upload/v1714000000/coffee_bag_1.jpg", true),
            
            new Product(UUID.randomUUID().toString(), "Colombia Supremo Medium Roast", "Coffee", "Grindery Reserve", 
                "A balanced medium roast featuring notes of chocolate, caramel, and a hint of cherry.", 22.00, 30, 
                "https://res.cloudinary.com/dbpl94opl/image/upload/v1714000000/coffee_bag_2.jpg", true),
            
            new Product(UUID.randomUUID().toString(), "Sumatra Mandheling Dark Roast", "Coffee", "Grindery Reserve", 
                "Earthy and full-bodied dark roast with low acidity and notes of dark chocolate and spice.", 23.50, 45, 
                "https://res.cloudinary.com/dbpl94opl/image/upload/v1714000000/coffee_bag_3.jpg", true),
            
            new Product(UUID.randomUUID().toString(), "Matcha Ceremonial Grade", "Tea", "Grindery Reserve", 
                "Premium stone-ground ceremonial matcha from Uji, Japan. Vibrant green color and smooth umami flavor.", 35.00, 20, 
                "https://res.cloudinary.com/dbpl94opl/image/upload/v1714000000/matcha.jpg", true),
            
            new Product(UUID.randomUUID().toString(), "Earl Grey Reserve", "Tea", "Grindery Reserve", 
                "Classic black tea infused with premium Italian bergamot oil.", 18.00, 60, 
                "https://res.cloudinary.com/dbpl94opl/image/upload/v1714000000/earl_grey.jpg", true),

            new Product(UUID.randomUUID().toString(), "Chemex Pour-Over Glass Coffeemaker", "Goods", "Chemex", 
                "The classic 8-cup Chemex pour-over glass coffeemaker. Made of non-porous Borosilicate glass.", 48.00, 15, 
                "https://res.cloudinary.com/dbpl94opl/image/upload/v1714000000/chemex.jpg", true),

            new Product(UUID.randomUUID().toString(), "Hario V60 Ceramic Dripper", "Goods", "Hario", 
                "Size 02 ceramic coffee dripper in white. Retains heat to ensure a constant temperature throughout the brewing cycle.", 25.00, 25, 
                "https://res.cloudinary.com/dbpl94opl/image/upload/v1714000000/v60.jpg", true)
        );

        List<Product> seededProducts = new ArrayList<>();
        
        // Let's just retrieve existing products to not duplicate endlessly, or just add them if it's empty
        List<Product> existingProducts = productDAO.getAllProducts();
        if (existingProducts.isEmpty()) {
            for (Product p : productsToCreate) {
                productDAO.createProduct(p);
                seededProducts.add(p);
                logger.info("Created product: {}", p.getName());
            }
        } else {
            seededProducts.addAll(existingProducts);
            logger.info("Products already exist. Skipping product seed.");
        }
        
        return seededProducts;
    }

    private static void seedOrders(OrderDAO orderDAO, List<User> users, List<Product> products) throws Exception {
        long existingOrders = orderDAO.getTotalOrdersCount();
        if (existingOrders > 0) {
            logger.info("Orders already exist. Skipping order seed.");
            return;
        }

        // Find customer users
        User customer1 = users.stream().filter(u -> u.getEmail().equals("alice@customer.com")).findFirst().orElse(users.get(0));
        User customer2 = users.stream().filter(u -> u.getEmail().equals("bob@customer.com")).findFirst().orElse(users.get(0));

        if (products.size() < 2) return; // safety

        // Order 1: Alice, PENDING
        List<Order.OrderItem> items1 = new ArrayList<>();
        items1.add(new Order.OrderItem(products.get(0).getProductId(), products.get(0).getName(), products.get(0).getPrice(), 2, products.get(0).getImageUrl()));
        items1.add(new Order.OrderItem(products.get(3).getProductId(), products.get(3).getName(), products.get(3).getPrice(), 1, products.get(3).getImageUrl()));
        
        double total1 = items1.stream().mapToDouble(Order.OrderItem::getSubtotal).sum();
        Order order1 = new Order(UUID.randomUUID().toString(), customer1.getUid(), items1, total1, "123 Alice St, Wonderland");
        order1.setStatus(Order.STATUS_PENDING);
        orderDAO.createOrder(order1);
        logger.info("Created Order 1 (PENDING) for {}", customer1.getEmail());

        // Order 2: Bob, PROCESSING
        List<Order.OrderItem> items2 = new ArrayList<>();
        items2.add(new Order.OrderItem(products.get(5).getProductId(), products.get(5).getName(), products.get(5).getPrice(), 1, products.get(5).getImageUrl()));
        
        double total2 = items2.stream().mapToDouble(Order.OrderItem::getSubtotal).sum();
        Order order2 = new Order(UUID.randomUUID().toString(), customer2.getUid(), items2, total2, "456 Bob Ave, Builder City");
        order2.setStatus(Order.STATUS_PROCESSING);
        orderDAO.createOrder(order2);
        logger.info("Created Order 2 (PROCESSING) for {}", customer2.getEmail());

        // Order 3: Alice, DELIVERED
        List<Order.OrderItem> items3 = new ArrayList<>();
        items3.add(new Order.OrderItem(products.get(1).getProductId(), products.get(1).getName(), products.get(1).getPrice(), 1, products.get(1).getImageUrl()));
        
        double total3 = items3.stream().mapToDouble(Order.OrderItem::getSubtotal).sum();
        Order order3 = new Order(UUID.randomUUID().toString(), customer1.getUid(), items3, total3, "123 Alice St, Wonderland");
        order3.setStatus(Order.STATUS_DELIVERED);
        orderDAO.createOrder(order3);
        logger.info("Created Order 3 (DELIVERED) for {}", customer1.getEmail());
    }
}
