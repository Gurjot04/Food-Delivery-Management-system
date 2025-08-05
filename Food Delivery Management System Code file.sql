-- 1. CUSTOMER Table
CREATE TABLE Customer (
    customer_id NUMBER,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    house_no VARCHAR2(20),
    sector VARCHAR2(20),
    city VARCHAR2(50),
    CONSTRAINT PK_Customer PRIMARY KEY (customer_id) 
);

-- 2. CUSTOMER_CONTACT Table
CREATE TABLE Customer_Contact (
    customer_id NUMBER,
    contact_no NUMBER,
    CONSTRAINT PK_Customer_Contact PRIMARY KEY (customer_id, contact_no),
    CONSTRAINT FK_Customer_Contact_Customer FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id) on delete cascade
);

-- 3. CUSTOMER_EMAIL Table
CREATE TABLE Customer_Email (
    customer_id NUMBER,
    email VARCHAR2(100),
    CONSTRAINT PK_Customer_Email PRIMARY KEY (customer_id, email),
    CONSTRAINT FK_Customer_Email_Customer FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id) on delete cascade
);

-- 4. VEHICLE Table
CREATE TABLE Vehicle (
    vehicle_id NUMBER,
    vehicle_type VARCHAR2(30),
    license_plate VARCHAR2(20),
    color VARCHAR2(20),
    model VARCHAR2(30),
    CONSTRAINT PK_Vehicle PRIMARY KEY (vehicle_id),
    CONSTRAINT UK_Vehicle_License UNIQUE (license_plate)
);


-- 5. DELIVERY_PERSON Table
CREATE TABLE DeliveryPerson (
    delivery_person_id NUMBER,
    name VARCHAR2(50),
    vehicle_id NUMBER,
    contact_number NUMBER,
    CONSTRAINT PK_DeliveryPerson PRIMARY KEY (delivery_person_id),
    CONSTRAINT FK_DeliveryPerson_Vehicle FOREIGN KEY (vehicle_id)
        REFERENCES Vehicle(vehicle_id) on delete cascade
);

-- 6. RESTAURANT Table
CREATE TABLE Restaurant (
    restaurant_id NUMBER,
    restaurant_name VARCHAR2(100),
    shop_no VARCHAR2(20),
    sector VARCHAR2(20),
    city VARCHAR2(50),
    website VARCHAR2(100),
    opening_hours VARCHAR2(20),
    closing_hours VARCHAR2(20),
    CONSTRAINT PK_Restaurant PRIMARY KEY (restaurant_id)
);

-- 7. RESTAURANT_CONTACT Table
CREATE TABLE Restaurant_Contact (
    restaurant_id NUMBER,
    contact_no number,
    CONSTRAINT PK_Restaurant_Contact PRIMARY KEY (restaurant_id, contact_no),
    CONSTRAINT FK_Restaurant_Contact_Restaurant FOREIGN KEY (restaurant_id)
        REFERENCES Restaurant(restaurant_id) on delete cascade
);

-- 8. MENU Table
CREATE TABLE Menu (
    menu_id NUMBER,
    restaurant_id NUMBER,
    item_name VARCHAR2(100),
    description VARCHAR2(500),
    price NUMBER(8,2),
    cuisine_type VARCHAR2(50),
    CONSTRAINT PK_Menu PRIMARY KEY (menu_id, restaurant_id),
    CONSTRAINT FK_Menu_Restaurant FOREIGN KEY (restaurant_id)
        REFERENCES Restaurant(restaurant_id) on delete cascade
);

-- 9. RESTAURANT_MENU Table
CREATE TABLE Restaurant_Menu (
    menu_id NUMBER,
    restaurant_id NUMBER,
    availability VARCHAR2(10),
    CONSTRAINT PK_Restaurant_Menu PRIMARY KEY (menu_id, restaurant_id),
    CONSTRAINT FK_Restaurant_Menu_Menu FOREIGN KEY (menu_id, restaurant_id)
        REFERENCES Menu(menu_id, restaurant_id) on delete cascade
);


-- 10. VEG Table
CREATE TABLE Veg (
    menu_id NUMBER,
    restaurant_id NUMBER,
    gluten_free VARCHAR2(5),
    vegan_friendly VARCHAR2(5),
    CONSTRAINT PK_Veg PRIMARY KEY (menu_id, restaurant_id),
    CONSTRAINT FK_Veg_Menu FOREIGN KEY (menu_id, restaurant_id)
        REFERENCES Menu(menu_id, restaurant_id) on delete cascade
);

-- 11. NON_VEG Table
CREATE TABLE Non_Veg (
    menu_id NUMBER,
    restaurant_id NUMBER,
    meat_type VARCHAR2(30),
    preparation_style VARCHAR2(50),
    CONSTRAINT PK_Non_Veg PRIMARY KEY (menu_id, restaurant_id),
    CONSTRAINT FK_Non_Veg_Menu FOREIGN KEY (menu_id, restaurant_id)
        REFERENCES Menu(menu_id, restaurant_id) on delete cascade
);

-- 12. ORDERS Table
CREATE TABLE Orders (
    order_id NUMBER,
    customer_id NUMBER,
    order_date DATE,
    total_amount NUMBER(10,2),
    house_no VARCHAR2(20),
    sector VARCHAR2(20),
    city VARCHAR2(50),
    delivery_person_id NUMBER,
    order_status VARCHAR2(20),
    CONSTRAINT PK_Orders PRIMARY KEY (order_id),
    CONSTRAINT FK_Orders_Customer FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id) on delete cascade,
    CONSTRAINT FK_Orders_DeliveryPerson FOREIGN KEY (delivery_person_id)
        REFERENCES DeliveryPerson(delivery_person_id) on delete cascade
);

-- 13. ORDER_DETAILS Table
CREATE TABLE Order_Details (
    order_id NUMBER,
    restaurant_id NUMBER,
    item_name VARCHAR2(100),
    quantity NUMBER,
    CONSTRAINT PK_Order_Details PRIMARY KEY (order_id, restaurant_id, item_name),
    CONSTRAINT FK_Order_Details_Orders FOREIGN KEY (order_id)
        REFERENCES Orders(order_id) on delete cascade,
    CONSTRAINT FK_Order_Details_Restaurant FOREIGN KEY (restaurant_id)
        REFERENCES Restaurant(restaurant_id) on delete cascade
);

-- 14. PAYMENT Table
CREATE TABLE Payment (
    order_id NUMBER,
    payment_id NUMBER,
    payment_type VARCHAR2(30),
    bill NUMBER(10,2),
    status VARCHAR2(20),
    CONSTRAINT PK_Payment PRIMARY KEY (order_id, payment_id),
    CONSTRAINT FK_Payment_Orders FOREIGN KEY (order_id)
        REFERENCES Orders(order_id) on delete cascade
);

INSERT INTO Customer (customer_id, first_name, last_name, house_no, sector, city) VALUES
(1, 'John', 'Doe', 'H101', 'Sector 1', 'Delhi'),
(2, 'Jane', 'Smith', 'H102', 'Sector 2', 'Mumbai'),
(3, 'Alice', 'Brown', 'H103', 'Sector 3', 'Delhi'),
(4, 'Bob', 'White', 'H104', 'Sector 4', 'Bangalore'),
(5, 'Tom', 'Green', 'H105', 'Sector 5', 'Mumbai'),
(6, 'Emma', 'Taylor', 'H106', 'Sector 6', 'Delhi'),
(7, 'Chris', 'Lee', 'H107', 'Sector 7', 'Bangalore'),
(8, 'Olivia', 'Martin', 'H108', 'Sector 8', 'Mumbai'),
(9, 'Daniel', 'Walker', 'H109', 'Sector 9', 'Bangalore'),
(10, 'Sophia', 'Hall', 'H110', 'Sector 10', 'Delhi'),
(11, 'Liam', 'Wilson', 'H111', 'Sector 11', 'Mumbai'),
(12, 'Mia', 'Clark', 'H112', 'Sector 12', 'Bangalore'),
(13, 'Noah', 'Lopez', 'H113', 'Sector 13', 'Delhi'),
(14, 'Isabella', 'Young', 'H114', 'Sector 14', 'Mumbai'),
(15, 'Lucas', 'Allen', 'H115', 'Sector 15', 'Bangalore'),
(16, 'Charlotte', 'King', 'H116', 'Sector 16', 'Delhi'),
(17, 'Elijah', 'Scott', 'H117', 'Sector 17', 'Mumbai'),
(18, 'Amelia', 'Adams', 'H118', 'Sector 18', 'Bangalore'),
(19, 'James', 'Baker', 'H119', 'Sector 19', 'Delhi'),
(20, 'Harper', 'Gonzalez', 'H120', 'Sector 20', 'Mumbai'),
(21, 'Henry', 'Nelson', 'H121', 'Sector 21', 'Bangalore'),
(22, 'Evelyn', 'Carter', 'H122', 'Sector 22', 'Delhi'),
(23, 'Alexander', 'Mitchell', 'H123', 'Sector 23', 'Mumbai'),
(24, 'Avery', 'Perez', 'H124', 'Sector 24', 'Bangalore'),
(25, 'Sebastian', 'Roberts', 'H125', 'Sector 25', 'Delhi'),
(26, 'Ella', 'Turner', 'H126', 'Sector 26', 'Mumbai'),
(27, 'Jack', 'Phillips', 'H127', 'Sector 27', 'Bangalore'),
(28, 'Scarlett', 'Campbell', 'H128', 'Sector 28', 'Delhi'),
(29, 'Owen', 'Parker', 'H129', 'Sector 29', 'Mumbai'),
(30, 'Lily', 'Evans', 'H130', 'Sector 30', 'Bangalore');

INSERT INTO Customer_Contact (customer_id, contact_no) VALUES
(1, 9876543210), (1, 9876543211),
(2, 9876543212), (2, 9876543213),
(3, 9876543214),
(4, 9876543215),
(5, 9876543216), (5, 9876543217),
(6, 9876543218),
(7, 9876543219),
(8, 9876543220), (8, 9876543221),
(9, 9876543222),
(10, 9876543223),
(11, 9876543224),
(12, 9876543225), (12, 9876543226),
(13, 9876543227),
(14, 9876543228),
(15, 9876543229), (15, 9876543230),
(16, 9876543231),
(17, 9876543232),
(18, 9876543233),
(19, 9876543234),
(20, 9876543235),
(21, 9876543236),
(22, 9876543237),
(23, 9876543238),
(24, 9876543239),
(25, 9876543240),
(26, 9876543241),
(27, 9876543242),
(28, 9876543243),
(29, 9876543244),
(30, 9876543245);

INSERT INTO Customer_Email (customer_id, email) VALUES
(1, 'john.doe@example.com'),
(1, 'john.doe.alt@example.com'),
(2, 'jane.smith@example.com'),
(3, 'alice.brown@example.com'),
(3, 'alice.b@example.com'),
(4, 'bob.white@example.com'),
(5, 'tom.green@example.com'),
(6, 'emma.taylor@example.com'),
(6, 'emma123@example.com'),
(7, 'chris.lee@example.com'),
(8, 'olivia.martin@example.com'),
(9, 'daniel.walker@example.com'),
(10, 'sophia.hall@example.com'),
(11, 'liam.wilson@example.com'),
(12, 'mia.clark@example.com'),
(13, 'noah.lopez@example.com'),
(14, 'isabella.young@example.com'),
(14, 'isabella.y@example.com'),
(15, 'lucas.allen@example.com'),
(16, 'charlotte.king@example.com'),
(17, 'elijah.scott@example.com'),
(18, 'amelia.adams@example.com'),
(19, 'james.baker@example.com'),
(20, 'harper.gonzalez@example.com'),
(21, 'henry.nelson@example.com'),
(22, 'evelyn.carter@example.com'),
(23, 'alex.mitchell@example.com'),
(24, 'avery.perez@example.com'),
(25, 'sebastian.roberts@example.com'),
(26, 'ella.turner@example.com'),
(27, 'jack.phillips@example.com'),
(28, 'scarlett.campbell@example.com'),
(29, 'owen.parker@example.com'),
(30, 'lily.evans@example.com');

INSERT INTO Vehicle (vehicle_id, vehicle_type, license_plate, color, model) VALUES
(1, 'Bike', 'ABC1234', 'Red', 'Yamaha FZ'),
(2, 'Scooter', 'XYZ5678', 'Blue', 'Honda Activa'),
(3, 'Bike', 'LMN9012', 'Black', 'Bajaj Pulsar'),
(4, 'Car', 'JKL3456', 'White', 'Suzuki Alto'),
(5, 'Scooter', 'PQR7890', 'Green', 'TVS Jupiter'),
(6, 'Bike', 'STU2345', 'Orange', 'Hero Splendor'),
(7, 'Car', 'DEF6789', 'Grey', 'Hyundai i10'),
(8, 'Bike', 'GHI0123', 'Blue', 'Royal Enfield'),
(9, 'Scooter', 'UVW4567', 'Black', 'Suzuki Access'),
(10, 'Bike', 'QWE0987', 'Red', 'KTM Duke');

INSERT INTO DeliveryPerson (delivery_person_id, name, vehicle_id, contact_number) VALUES
(1, 'Rajesh Kumar', 1, 8001000100),
(2, 'Suman Roy', 2, 8001000101),
(3, 'Amit Sharma', 3, 8001000102),
(4, 'Rina Das', 4, 8001000103),
(5, 'Vikram Singh', 5, 8001000104),
(6, 'Neha Gupta', 6, 8001000105),
(7, 'Pooja Mehta', 7, 8001000106),
(8, 'Arjun Patel', 8, 8001000107),
(9, 'Karan Bhatt', 9, 8001000108),
(10, 'Sonal Joshi', 10, 8001000109),
(11, 'Deepak Yadav', 1, 8001000110),
(12, 'Alok Sen', 2, 8001000111),
(13, 'Harsha Nair', 3, 8001000112),
(14, 'Tanvi Rao', 4, 8001000113),
(15, 'Rohit Verma', 5, 8001000114),
(16, 'Sneha Mishra', 6, 8001000115),
(17, 'Pratik Shah', 7, 8001000116),
(18, 'Geeta Kapoor', 8, 8001000117),
(19, 'Ashwin Iyer', 9, 8001000118),
(20, 'Nidhi Bansal', 10, 8001000119),
(21, 'Abhay Jain', 1, 8001000120),
(22, 'Kirti Desai', 2, 8001000121),
(23, 'Varun Goel', 3, 8001000122),
(24, 'Divya Saxena', 4, 8001000123),
(25, 'Ramesh Menon', 5, 8001000124),
(26, 'Meena Rawat', 6, 8001000125),
(27, 'Nikhil Chawla', 7, 8001000126),
(28, 'Anita Reddy', 8, 8001000127),
(29, 'Tarun Sehgal', 9, 8001000128),
(30, 'Isha Khanna', 10, 8001000129);

INSERT INTO Restaurant (restaurant_id, restaurant_name, shop_no, sector, city, website, opening_hours, closing_hours) VALUES
(1, 'Tandoori Treats', 'S101', 'Sector 1', 'Delhi', 'www.tandooritreats.com', '10:00', '22:00'),
(2, 'Green Garden', 'S102', 'Sector 2', 'Mumbai', 'www.greengarden.com', '09:00', '21:00'),
(3, 'Spicy Spoon', 'S103', 'Sector 3', 'Bangalore', 'www.spicyspoon.com', '11:00', '23:00'),
(4, 'Pizza Palace', 'S104', 'Sector 4', 'Delhi', 'www.pizzapalace.com', '10:30', '22:30'),
(5, 'Biryani House', 'S105', 'Sector 5', 'Mumbai', 'www.biryanihouse.com', '12:00', '23:00'),
(6, 'Curry Corner', 'S106', 'Sector 6', 'Bangalore', 'www.currycorner.com', '09:30', '21:30'),
(7, 'Wrap & Roll', 'S107', 'Sector 7', 'Delhi', 'www.wrapnroll.com', '10:00', '22:00'),
(8, 'Burger Binge', 'S108', 'Sector 8', 'Mumbai', 'www.burgerbinge.com', '11:00', '23:00'),
(9, 'Sushi Central', 'S109', 'Sector 9', 'Bangalore', 'www.sushicentral.com', '12:00', '22:00'),
(10, 'Vegan Vibes', 'S110', 'Sector 10', 'Delhi', 'www.veganvibes.com', '09:00', '20:00');

INSERT INTO Restaurant_Contact (restaurant_id, contact_no) VALUES
(1, 9988776651),
(2, 9988776652),
(3, 9988776653),
(4, 9988776654),
(5, 9988776655),
(6, 9988776656),
(7, 9988776657),
(8, 9988776658),
(9, 9988776659),
(10, 9988776660);

INSERT INTO Menu (menu_id, restaurant_id, item_name, description, price, cuisine_type) VALUES
(1, 1, 'Paneer Butter Masala', 'Creamy paneer cooked in tomato-based gravy', 180, 'North Indian'),
(2, 1, 'Veg Biryani', 'Fragrant basmati rice with mixed vegetables and spices', 150, 'North Indian'),
(3, 2, 'Chicken Curry', 'Spicy chicken curry with rich gravy', 220, 'South Indian'),
(4, 2, 'Margherita Pizza', 'Classic pizza with cheese and tomato sauce', 200, 'Italian'),
(5, 3, 'Veg Burger', 'Grilled vegetable patty with fresh veggies in a bun', 120, 'Fast Food'),
(6, 3, 'Chicken Burger', 'Grilled chicken patty with lettuce and sauces', 150, 'Fast Food'),
(7, 4, 'Veg Wrap', 'Soft tortilla filled with spiced veggies', 130, 'Fast Food'),
(8, 4, 'Chicken Wrap', 'Tortilla wrap with spicy chicken and sauces', 160, 'Fast Food'),
(9, 5, 'Mushroom Soup', 'Creamy soup with fresh mushrooms', 110, 'Continental'),
(10, 5, 'Hot & Sour Soup', 'Spicy and tangy soup with veggies', 100, 'Chinese'),
(11, 6, 'Spring Rolls', 'Crispy rolls stuffed with vegetables', 140, 'Chinese'),
(12, 6, 'Fish Curry', 'Spicy fish curry with coastal spices', 240, 'South Indian'),
(13, 7, 'Fried Rice', 'Stir-fried rice with vegetables and sauces', 130, 'Chinese'),
(14, 7, 'Chilli Paneer', 'Paneer tossed in spicy sauce', 170, 'Chinese'),
(15, 8, 'Egg Curry', 'Boiled eggs in spicy curry', 190, 'North Indian'),
(16, 4, 'Butter Chicken', 'Creamy chicken dish with butter and tomato', 250, 'North Indian'),
(17, 9, 'Tandoori Chicken', 'Chicken roasted in tandoor with spices', 270, 'Mughlai'),
(18, 9, 'Palak Paneer', 'Spinach and paneer cooked in mild spices', 175, 'North Indian'),
(19, 10, 'Aloo Gobi', 'Cauliflower and potato stir-fry', 145, 'North Indian'),
(20, 10, 'Dal Tadka', 'Yellow dal tempered with garlic and ghee', 135, 'North Indian'),
(21, 1, 'Roti', 'Whole wheat flatbread', 20, 'North Indian'),
(22, 5, 'Naan', 'Soft leavened flatbread', 25, 'North Indian'),
(23, 3, 'Mutton Korma', 'Slow-cooked mutton in rich curry', 280, 'Mughlai'),
(24, 4, 'Vegan Bowl', 'Healthy bowl with grains, greens, and tofu', 160, 'Vegan'),
(25, 5, 'Sushi Roll', 'Japanese sushi with rice and vegetables', 300, 'Japanese'),
(26, 6, 'Green Salad', 'Fresh lettuce, cucumber, and tomatoes', 90, 'Continental'),
(27, 6, 'Pasta Alfredo', 'Pasta in white cream sauce', 190, 'Italian'),
(28, 8, 'Paneer Tikka', 'Grilled paneer cubes marinated in spices', 185, 'North Indian'),
(29, 9, 'Chicken Tikka', 'Grilled chicken chunks with spices', 230, 'Mughlai'),
(30, 10, 'Veg Manchurian', 'Fried veg balls in Chinese gravy', 160, 'Chinese');

INSERT INTO Veg (menu_id, restaurant_id, gluten_free, vegan_friendly) VALUES
(1, 1, 'No', 'No'),     -- Paneer Butter Masala
(2, 1, 'No', 'No'),     -- Veg Biryani
(4, 2, 'No', 'No'),     -- Margherita Pizza
(5, 3, 'Yes', 'No'),    -- Veg Burger
(7, 4, 'Yes', 'No'),    -- Veg Wrap
(9, 5, 'Yes', 'Yes'),   -- Mushroom Soup
(10, 5, 'Yes', 'Yes'),  -- Hot & Sour Soup
(11, 6, 'Yes', 'No'),   -- Spring Rolls
(13, 7, 'No', 'Yes'),   -- Fried Rice
(14, 7, 'Yes', 'No'),   -- Chilli Paneer
(18, 9, 'No', 'No'),    -- Palak Paneer
(19, 10, 'Yes', 'Yes'), -- Aloo Gobi
(20, 10, 'Yes', 'Yes'), -- Dal Tadka
(21, 1, 'Yes', 'Yes'),  -- Roti
(22, 5, 'No', 'Yes'),   -- Naan
(24, 4, 'Yes', 'Yes'),  -- Vegan Bowl
(26, 6, 'Yes', 'Yes'),  -- Green Salad
(30, 10, 'No', 'No');   -- Veg Manchurian


INSERT INTO Non_Veg (menu_id, restaurant_id, meat_type, preparation_style) VALUES
(3, 2, 'Chicken', 'Curry'),             -- Chicken Curry
(6, 3, 'Chicken', 'Grilled Burger'),    -- Chicken Burger
(8, 4, 'Chicken', 'Grilled Wrap'),      -- Chicken Wrap
(12, 6, 'Fish', 'Coastal Curry'),       -- Fish Curry
(15, 8, 'Egg', 'Curry'),                -- Egg Curry
(16, 4, 'Chicken', 'Butter Gravy'),     -- Butter Chicken
(17, 9, 'Chicken', 'Tandoori Roasted'), -- Tandoori Chicken
(23, 3, 'Mutton', 'Rich Gravy'),        -- Mutton Korma
(25, 5, 'Fish', 'Sushi Style'),         -- Sushi Roll
(27, 6, 'Chicken', 'Creamy Pasta'),     -- Pasta Alfredo
(28, 8, 'Chicken', 'Tikka Grilled'),    -- Paneer Tikka was wrongly classified earlier
(29, 9, 'Chicken', 'Tikka Grilled');    -- Chicken Tikka


INSERT INTO Restaurant_Menu (restaurant_id, menu_id) VALUES
(1, 1), (1, 2), (1, 21),
(2, 3), (2, 4),
(3, 5), (3, 6), (3, 23),
(4, 7), (4, 8), (4, 16), (4, 24),
(5, 9), (5, 10), (5, 22), (5, 25),
(6, 11), (6, 12), (6, 26), (6, 27),
(7, 13), (7, 14),
(8, 15), (8, 28),
(9, 17), (9, 18), (9, 29),
(10, 19), (10, 20), (10, 30);

INSERT INTO Orders (
    order_id, customer_id, order_date, total_amount,
    house_no, sector, city, delivery_person_id, order_status
) VALUES
(1, 1, TO_DATE('2024-04-01 12:30', 'YYYY-MM-DD HH24:MI'), 350.00, 'H101', 'Sector 1', 'Delhi', 1, 'Delivered'),
(2, 1, TO_DATE('2024-04-03 13:15', 'YYYY-MM-DD HH24:MI'), 420.00, 'H101', 'Sector 1', 'Delhi', 2, 'Delivered'),
(3, 2, TO_DATE('2024-04-02 14:00', 'YYYY-MM-DD HH24:MI'), 220.00, 'H102', 'Sector 2', 'Mumbai', 3, 'Delivered'),
(4, 2, TO_DATE('2024-04-05 13:00', 'YYYY-MM-DD HH24:MI'), 310.00, 'H102', 'Sector 2', 'Mumbai', 4, 'Delivered'),
(5, 3, TO_DATE('2024-04-01 12:45', 'YYYY-MM-DD HH24:MI'), 180.00, 'H103', 'Sector 3', 'Delhi', 5, 'Delivered'),
(6, 3, TO_DATE('2024-04-04 14:30', 'YYYY-MM-DD HH24:MI'), 270.00, 'H103', 'Sector 3', 'Delhi', 6, 'Delivered'),
(7, 4, TO_DATE('2024-04-02 15:00', 'YYYY-MM-DD HH24:MI'), 260.00, 'H104', 'Sector 4', 'Bangalore', 7, 'Delivered'),
(8, 4, TO_DATE('2024-04-06 15:45', 'YYYY-MM-DD HH24:MI'), 330.00, 'H104', 'Sector 4', 'Bangalore', 8, 'Delivered'),
(9, 5, TO_DATE('2024-04-03 16:00', 'YYYY-MM-DD HH24:MI'), 150.00, 'H105', 'Sector 5', 'Mumbai', 9, 'Delivered'),
(10, 5, TO_DATE('2024-04-07 16:30', 'YYYY-MM-DD HH24:MI'), 340.00, 'H105', 'Sector 5', 'Mumbai', 10, 'Delivered'),
(11, 6, TO_DATE('2024-04-02 13:00', 'YYYY-MM-DD HH24:MI'), 250.00, 'H106', 'Sector 6', 'Delhi', 11, 'Delivered'),
(12, 7, TO_DATE('2024-04-03 13:30', 'YYYY-MM-DD HH24:MI'), 180.00, 'H107', 'Sector 7', 'Bangalore', 12, 'Delivered'),
(13, 8, TO_DATE('2024-04-04 14:00', 'YYYY-MM-DD HH24:MI'), 360.00, 'H108', 'Sector 8', 'Mumbai', 13, 'Delivered'),
(14, 9, TO_DATE('2024-04-05 14:30', 'YYYY-MM-DD HH24:MI'), 275.00, 'H109', 'Sector 9', 'Bangalore', 14, 'Delivered'),
(15, 10, TO_DATE('2024-04-06 15:00', 'YYYY-MM-DD HH24:MI'), 400.00, 'H110', 'Sector 10', 'Delhi', 15, 'Delivered'),
(16, 11, TO_DATE('2024-04-07 15:30', 'YYYY-MM-DD HH24:MI'), 190.00, 'H111', 'Sector 11', 'Mumbai', 16, 'Delivered'),
(17, 12, TO_DATE('2024-04-08 16:00', 'YYYY-MM-DD HH24:MI'), 320.00, 'H112', 'Sector 12', 'Bangalore', 17, 'Delivered'),
(18, 13, TO_DATE('2024-04-09 16:30', 'YYYY-MM-DD HH24:MI'), 280.00, 'H113', 'Sector 13', 'Delhi', 18, 'Delivered'),
(19, 14, TO_DATE('2024-04-10 17:00', 'YYYY-MM-DD HH24:MI'), 360.00, 'H114', 'Sector 14', 'Mumbai', 19, 'Delivered'),
(20, 15, TO_DATE('2024-04-11 17:30', 'YYYY-MM-DD HH24:MI'), 150.00, 'H115', 'Sector 15', 'Bangalore', 20, 'Delivered'),
(21, 16, TO_DATE('2024-04-12 18:00', 'YYYY-MM-DD HH24:MI'), 290.00, 'H116', 'Sector 16', 'Delhi', 21, 'Delivered'),
(22, 17, TO_DATE('2024-04-13 18:30', 'YYYY-MM-DD HH24:MI'), 310.00, 'H117', 'Sector 17', 'Mumbai', 22, 'Delivered'),
(23, 18, TO_DATE('2024-04-14 19:00', 'YYYY-MM-DD HH24:MI'), 270.00, 'H118', 'Sector 18', 'Bangalore', 23, 'Delivered'),
(24, 19, TO_DATE('2024-04-15 19:30', 'YYYY-MM-DD HH24:MI'), 190.00, 'H119', 'Sector 19', 'Delhi', 24, 'Delivered'),
(25, 20, TO_DATE('2024-04-16 20:00', 'YYYY-MM-DD HH24:MI'), 400.00, 'H120', 'Sector 20', 'Mumbai', 25, 'Delivered'),
(26, 21, TO_DATE('2024-04-17 20:30', 'YYYY-MM-DD HH24:MI'), 215.00, 'H121', 'Sector 21', 'Bangalore', 26, 'Delivered'),
(27, 22, TO_DATE('2024-04-18 21:00', 'YYYY-MM-DD HH24:MI'), 260.00, 'H122', 'Sector 22', 'Delhi', 27, 'Delivered'),
(28, 23, TO_DATE('2024-04-19 21:30', 'YYYY-MM-DD HH24:MI'), 300.00, 'H123', 'Sector 23', 'Mumbai', 28, 'Delivered'),
(29, 24, TO_DATE('2024-04-20 22:00', 'YYYY-MM-DD HH24:MI'), 310.00, 'H124', 'Sector 24', 'Bangalore', 29, 'Delivered'),
(30, 25, TO_DATE('2024-04-21 22:30', 'YYYY-MM-DD HH24:MI'), 185.00, 'H125', 'Sector 25', 'Delhi', 30, 'Delivered');

INSERT INTO Order_Details (order_id, restaurant_id, item_name, quantity) VALUES
(1, 1, 'Paneer Butter Masala', 2),
(2, 1, 'Chicken Biryani', 1),
(3, 2, 'Veg Burger', 3),
(4, 2, 'French Fries', 2),
(5, 3, 'Margherita Pizza', 1),
(6, 3, 'Pasta Alfredo', 2),
(7, 4, 'Sushi Roll', 4),
(8, 4, 'Miso Soup', 1),
(9, 5, 'Tandoori Chicken', 2),
(10, 5, 'Butter Naan', 4),
(11, 6, 'Falafel Wrap', 2),
(12, 7, 'Chole Bhature', 1),
(13, 8, 'Mutton Curry', 2),
(14, 9, 'Hakka Noodles', 3),
(15, 10, 'Spring Rolls', 2),
(16, 1, 'Dal Makhani', 1),
(17, 2, 'Cheese Sandwich', 2),
(18, 3, 'Veggie Delight Sub', 1),
(19, 4, 'Kimchi Fried Rice', 2),
(20, 5, 'Fish Curry', 1),
(21, 6, 'Paneer Tikka', 3),
(22, 7, 'Rajma Rice', 2),
(23, 8, 'Butter Chicken', 1),
(24, 9, 'Fried Momos', 2),
(25, 10, 'Veg Pulao', 3),
(26, 1, 'Tacos', 2),
(27, 2, 'Grilled Sandwich', 2),
(28, 3, 'Cheesy Nachos', 1),
(29, 4, 'Veg Manchurian', 3),
(30, 5, 'Garlic Bread', 2);

INSERT INTO Payment (payment_id, order_id, payment_type, bill, status) VALUES 
(101, 1, 'Credit Card', 180, 'Completed'),
(102, 2, 'UPI', 150, 'Pending'),
(103, 3, 'Cash', 220, 'Completed'),
(104, 4, 'UPI', 200, 'Failed'),
(105, 5, 'Credit Card', 120, 'Completed'),
(106, 6, 'UPI', 150, 'Pending'),
(107, 7, 'Cash', 130, 'Completed'),
(108, 8, 'UPI', 160, 'Failed'),
(109, 9, 'Credit Card', 110, 'Completed'),
(110, 10, 'UPI', 100, 'Pending'),
(111, 11, 'Cash', 140, 'Completed'),
(112, 12, 'Credit Card', 240, 'Completed'),
(113, 13, 'UPI', 130, 'Pending'),
(114, 14, 'UPI', 170, 'Completed'),
(115, 15, 'Cash', 190, 'Pending'),
(116, 16, 'UPI', 250, 'Completed'),
(117, 17, 'Credit Card', 270, 'Failed'),
(118, 18, 'UPI', 175, 'Completed'),
(119, 19, 'Cash', 145, 'Pending'),
(120, 20, 'UPI', 135, 'Completed'),
(121, 21, 'Credit Card', 60, 'Failed'),
(122, 22, 'UPI', 80, 'Completed'),
(123, 23, 'Cash', 280, 'Pending'),
(124, 24, 'UPI', 160, 'Completed'),
(125, 25, 'Credit Card', 300, 'Completed'),
(126, 26, 'UPI', 90, 'Failed'),
(127, 27, 'Cash', 190, 'Pending'),
(128, 28, 'UPI', 185, 'Completed'),
(129, 29, 'Credit Card', 230, 'Pending'),
(130, 30, 'UPI', 160, 'Completed');



CREATE OR REPLACE PROCEDURE Insert_Customer(
    p_customer_id IN NUMBER,
    p_first_name IN VARCHAR2,
    p_last_name IN VARCHAR2,
    p_house_no IN VARCHAR2,
    p_sector IN VARCHAR2,
    p_city IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Customer(customer_id, first_name, last_name, house_no, sector, city)
    VALUES (p_customer_id, p_first_name, p_last_name, p_house_no, p_sector, p_city);
END;
/

BEGIN
    Insert_Customer(
        p_customer_id => &p_customer_id,
        p_first_name => '&p_first_name',
        p_last_name => '&p_last_name',
        p_house_no => '&p_house_no',
        p_sector => '&p_sector',
        p_city => '&p_city'
    );
END;
/


CREATE OR REPLACE PROCEDURE Insert_Customer_Contact(
    p_customer_id IN NUMBER,
    p_contact_no IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Customer_Contact(customer_id, contact_no)
    VALUES (p_customer_id, p_contact_no);
END;
/

CREATE OR REPLACE PROCEDURE Insert_Customer_Email(
    p_customer_id IN NUMBER,
    p_email IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Customer_Email(customer_id, email)
    VALUES (p_customer_id, p_email);
END;
/

CREATE OR REPLACE PROCEDURE Insert_Vehicle(
    p_vehicle_id IN NUMBER,
    p_vehicle_type IN VARCHAR2,
    p_license_plate IN VARCHAR2,
    p_color IN VARCHAR2,
    p_model IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Vehicle(vehicle_id, vehicle_type, license_plate, color, model)
    VALUES (p_vehicle_id, p_vehicle_type, p_license_plate, p_color, p_model);
END;
/

CREATE OR REPLACE PROCEDURE Insert_DeliveryPerson(
    p_delivery_person_id IN NUMBER,
    p_name IN VARCHAR2,
    p_vehicle_id IN NUMBER,
    p_contact_number IN VARCHAR2
)
IS
BEGIN
    INSERT INTO DeliveryPerson(delivery_person_id, name, vehicle_id, contact_number)
    VALUES (p_delivery_person_id, p_name, p_vehicle_id, p_contact_number);
END;
/

CREATE OR REPLACE PROCEDURE Insert_Restaurant(
    p_restaurant_id IN NUMBER,
    p_restaurant_name IN VARCHAR2,
    p_shop_no IN VARCHAR2,
    p_sector IN VARCHAR2,
    p_city IN VARCHAR2,
    p_website IN VARCHAR2,
    p_opening_hours IN VARCHAR2,
    p_closing_hours IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Restaurant(restaurant_id, restaurant_name, shop_no, sector, city, website, opening_hours, closing_hours)
    VALUES (p_restaurant_id, p_restaurant_name, p_shop_no, p_sector, p_city, p_website, p_opening_hours, p_closing_hours);
END;
/

CREATE OR REPLACE PROCEDURE Insert_Restaurant_Contact(
    p_restaurant_id IN NUMBER,
    p_contact_no IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Restaurant_Contact(restaurant_id, contact_no)
    VALUES (p_restaurant_id, p_contact_no);
END;
/

CREATE OR REPLACE PROCEDURE Insert_Menu(
    p_menu_id IN NUMBER,
    p_restaurant_id IN NUMBER,
    p_item_name IN VARCHAR2,
    p_description IN VARCHAR2,
    p_price IN NUMBER,
    p_cuisine_type IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Menu(menu_id, restaurant_id, item_name, description, price, cuisine_type)
    VALUES (p_menu_id, p_restaurant_id, p_item_name, p_description, p_price, p_cuisine_type);
END;
/

CREATE OR REPLACE PROCEDURE Insert_Restaurant_Menu(
    p_menu_id IN NUMBER,
    p_restaurant_id IN NUMBER,
    p_availability IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Restaurant_Menu(menu_id, restaurant_id, availability)
    VALUES (p_menu_id, p_restaurant_id, p_availability);
END;
/

CREATE OR REPLACE PROCEDURE Insert_Veg(
    p_menu_id IN NUMBER,
    p_restaurant_id IN NUMBER,
    p_gluten_free IN VARCHAR2,
    p_vegan_friendly IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Veg(menu_id, restaurant_id, gluten_free, vegan_friendly)
    VALUES (p_menu_id, p_restaurant_id, p_gluten_free, p_vegan_friendly);
END;
/

CREATE OR REPLACE PROCEDURE Insert_Non_Veg(
    p_menu_id IN NUMBER,
    p_restaurant_id IN NUMBER,
    p_meat_type IN VARCHAR2,
    p_preparation_style IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Non_Veg(menu_id, restaurant_id, meat_type, preparation_style)
    VALUES (p_menu_id, p_restaurant_id, p_meat_type, p_preparation_style);
END;
/

CREATE OR REPLACE PROCEDURE Insert_Orders(
    p_order_id IN NUMBER,
    p_customer_id IN NUMBER,
    p_order_date IN DATE,
    p_total_amount IN NUMBER,
    p_house_no IN VARCHAR2,
    p_sector IN VARCHAR2,
    p_city IN VARCHAR2,
    p_delivery_person_id IN NUMBER,
    p_order_status IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Orders(order_id, customer_id, order_date, total_amount, house_no, sector, city, delivery_person_id, order_status)
    VALUES (p_order_id, p_customer_id, p_order_date, p_total_amount, p_house_no, p_sector, p_city, p_delivery_person_id, p_order_status);
END;
/

BEGIN
    Insert_Orders(
        p_order_id => &p_order_id,
        p_customer_id => &p_customer_id,
        p_order_date => TO_DATE('&Enter_Order_Date (DD-MM-YYYY)', 'DD-MM-YYYY'),
        p_total_amount => &p_total_amount,
        p_house_no => '&p_house_no',
        p_sector => '&p_sector',
        p_city => '&p_city',
        p_delivery_person_id => &p_delivery_person_id,
        p_order_status => '&p_order_status'
    );
END;    

CREATE OR REPLACE PROCEDURE Insert_Order_Details(
    p_order_id IN NUMBER,
    p_restaurant_id IN NUMBER,
    p_item_name IN VARCHAR2,
    p_quantity IN NUMBER
)
IS
BEGIN
    INSERT INTO Order_Details(order_id, restaurant_id, item_name, quantity)
    VALUES (p_order_id, p_restaurant_id, p_item_name, p_quantity);
END;
/

CREATE OR REPLACE PROCEDURE Insert_Payment(
    p_order_id IN NUMBER,
    p_payment_id IN NUMBER,
    p_payment_type IN VARCHAR2,
    p_bill IN NUMBER,
    p_status IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Payment(order_id, payment_id, payment_type, bill, status)
    VALUES (p_order_id, p_payment_id, p_payment_type, p_bill, p_status);
END;
/


DECLARE
    CURSOR customer_cursor IS
        SELECT customer_id, first_name, last_name, house_no, sector, city FROM customer;

    v_customer_id customer.customer_id%TYPE;
    v_first_name customer.first_name%TYPE;
    v_last_name customer.last_name%TYPE;
    v_house_no customer.house_no%TYPE;
    v_sector customer.sector%TYPE;
    v_city customer.city%TYPE;
BEGIN
    OPEN customer_cursor;
    LOOP
        FETCH customer_cursor INTO v_customer_id, v_first_name, v_last_name, v_house_no, v_sector, v_city;
        EXIT WHEN customer_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Customer: ' || v_customer_id || ', ' || v_first_name || ' ' || v_last_name);
    END LOOP;
    CLOSE customer_cursor;
END;
/

DECLARE
    CURSOR customer_contact_cursor IS
        SELECT customer_id, contact_no FROM customer_contact;

    v_customer_id customer_contact.customer_id%TYPE;
    v_contact_no customer_contact.contact_no%TYPE;
BEGIN
    OPEN customer_contact_cursor;
    LOOP
        FETCH customer_contact_cursor INTO v_customer_id, v_contact_no;
        EXIT WHEN customer_contact_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Customer Contact: ' || v_customer_id || ', ' || v_contact_no);
    END LOOP;
    CLOSE customer_contact_cursor;
END;
/

DECLARE
    CURSOR customer_email_cursor IS
        SELECT customer_id, email FROM customer_email;

    v_customer_id customer_email.customer_id%TYPE;
    v_email customer_email.email%TYPE;
BEGIN
    OPEN customer_email_cursor;
    LOOP
        FETCH customer_email_cursor INTO v_customer_id, v_email;
        EXIT WHEN customer_email_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Customer Email: ' || v_customer_id || ', ' || v_email);
    END LOOP;
    CLOSE customer_email_cursor;
END;
/


DECLARE
    CURSOR vehicle_cursor IS
        SELECT vehicle_id, vehicle_type, license_plate, color, model FROM vehicle;

    v_vehicle_id vehicle.vehicle_id%TYPE;
    v_vehicle_type vehicle.vehicle_type%TYPE;
    v_license_plate vehicle.license_plate%TYPE;
    v_color vehicle.color%TYPE;
    v_model vehicle.model%TYPE;
BEGIN
    OPEN vehicle_cursor;
    LOOP
        FETCH vehicle_cursor INTO v_vehicle_id, v_vehicle_type, v_license_plate, v_color, v_model;
        EXIT WHEN vehicle_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Vehicle: ' || v_vehicle_id || ', ' || v_vehicle_type || ', ' || v_license_plate);
    END LOOP;
    CLOSE vehicle_cursor;
END;
/

DECLARE
    CURSOR deliveryperson_cursor IS
        SELECT delivery_person_id, name, vehicle_id, contact_number FROM DeliveryPerson;

    v_delivery_person_id DeliveryPerson.delivery_person_id%TYPE;
    v_name DeliveryPerson.name%TYPE;
    v_vehicle_id DeliveryPerson.vehicle_id%TYPE;
    v_contact_number DeliveryPerson.contact_number%TYPE;
BEGIN
    OPEN deliveryperson_cursor;
    LOOP
        FETCH deliveryperson_cursor INTO v_delivery_person_id, v_name, v_vehicle_id, v_contact_number;
        EXIT WHEN deliveryperson_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Delivery Person: ' || v_delivery_person_id || ', ' || v_name);
    END LOOP;
    CLOSE deliveryperson_cursor;
END;
/

DECLARE
    CURSOR restaurant_cursor IS
        SELECT restaurant_id, restaurant_name, shop_no, sector, city, website, opening_hours, closing_hours
        FROM Restaurant;

    v_restaurant_id Restaurant.restaurant_id%TYPE;
    v_restaurant_name Restaurant.restaurant_name%TYPE;
    v_shop_no Restaurant.shop_no%TYPE;
    v_sector Restaurant.sector%TYPE;
    v_city Restaurant.city%TYPE;
    v_website Restaurant.website%TYPE;
    v_opening_hours Restaurant.opening_hours%TYPE;
    v_closing_hours Restaurant.closing_hours%TYPE;
BEGIN
    OPEN restaurant_cursor;
    LOOP
        FETCH restaurant_cursor INTO v_restaurant_id, v_restaurant_name, v_shop_no, v_sector, v_city, v_website, v_opening_hours, v_closing_hours;
        EXIT WHEN restaurant_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Restaurant: ' || v_restaurant_id || ', ' || v_restaurant_name || ', Shop No: ' || v_shop_no || ', Sector: ' || v_sector || ', City: ' || v_city || ', Website: ' || v_website || ', Opening Hours: ' || v_opening_hours || ', Closing Hours: ' || v_closing_hours);
    END LOOP;
    CLOSE restaurant_cursor;
END;


DECLARE
    CURSOR restaurant_contact_cursor IS
        SELECT restaurant_id, contact_no FROM restaurant_contact;

    v_restaurant_id restaurant_contact.restaurant_id%TYPE;
    v_contact_no restaurant_contact.contact_no%TYPE;
BEGIN
    OPEN restaurant_contact_cursor;
    LOOP
        FETCH restaurant_contact_cursor INTO v_restaurant_id, v_contact_no;
        EXIT WHEN restaurant_contact_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Restaurant Contact: ' || v_restaurant_id || ', ' || v_contact_no);
    END LOOP;
    CLOSE restaurant_contact_cursor;
END;
/

DECLARE
    CURSOR menu_cursor IS
        SELECT menu_id, restaurant_id, item_name, description, price, cuisine_type
        FROM Menu;

    v_menu_id Menu.menu_id%TYPE;
    v_restaurant_id Menu.restaurant_id%TYPE;
    v_item_name Menu.item_name%TYPE;
    v_description Menu.description%TYPE;
    v_price Menu.price%TYPE;
    v_cuisine_type Menu.cuisine_type%TYPE;
BEGIN
    OPEN menu_cursor;
    LOOP
        FETCH menu_cursor INTO v_menu_id, v_restaurant_id, v_item_name, v_description, v_price, v_cuisine_type;
        EXIT WHEN menu_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Menu Item: ' || v_menu_id || ', ' || v_item_name || ', Rs.' || v_price || ', Cuisine: ' || v_cuisine_type);
    END LOOP;
    CLOSE menu_cursor;
END;
/

DECLARE
    CURSOR restaurant_menu_cursor IS
        SELECT menu_id, restaurant_id, availability
        FROM Restaurant_Menu;

    v_menu_id Restaurant_Menu.menu_id%TYPE;
    v_restaurant_id Restaurant_Menu.restaurant_id%TYPE;
    v_availability Restaurant_Menu.availability%TYPE;
BEGIN
    OPEN restaurant_menu_cursor;
    LOOP
        FETCH restaurant_menu_cursor INTO v_menu_id, v_restaurant_id, v_availability;
        EXIT WHEN restaurant_menu_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Restaurant Menu: ' || v_menu_id || ', ' || v_availability);
    END LOOP;
    CLOSE restaurant_menu_cursor;
END;
/

DECLARE
    CURSOR veg_cursor IS
        SELECT menu_id, restaurant_id, gluten_free, vegan_friendly
        FROM Veg;

    v_menu_id Veg.menu_id%TYPE;
    v_restaurant_id Veg.restaurant_id%TYPE;
    v_gluten_free Veg.gluten_free%TYPE;
    v_vegan_friendly Veg.vegan_friendly%TYPE;
BEGIN
    OPEN veg_cursor;
    LOOP
        FETCH veg_cursor INTO v_menu_id, v_restaurant_id, v_gluten_free, v_vegan_friendly;
        EXIT WHEN veg_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Veg Item: ' || v_menu_id || ', Gluten Free: ' || v_gluten_free || ', Vegan Friendly: ' || v_vegan_friendly);
    END LOOP;
    CLOSE veg_cursor;
END;
/

DECLARE
    CURSOR non_veg_cursor IS
        SELECT menu_id, restaurant_id, meat_type, preparation_style
        FROM Non_Veg;

    v_menu_id Non_Veg.menu_id%TYPE;
    v_restaurant_id Non_Veg.restaurant_id%TYPE;
    v_meat_type Non_Veg.meat_type%TYPE;
    v_preparation_style Non_Veg.preparation_style%TYPE;
BEGIN
    OPEN non_veg_cursor;
    LOOP
        FETCH non_veg_cursor INTO v_menu_id, v_restaurant_id, v_meat_type, v_preparation_style;
        EXIT WHEN non_veg_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Non-Veg Item: ' || v_menu_id || ', Meat: ' || v_meat_type || ', Style: ' || v_preparation_style);
    END LOOP;
    CLOSE non_veg_cursor;
END;
/


DECLARE
    CURSOR orders_cursor IS
        SELECT order_id, customer_id, order_date, total_amount, house_no, sector, city, delivery_person_id, order_status
        FROM Orders;

    v_order_id Orders.order_id%TYPE;
    v_customer_id Orders.customer_id%TYPE;
    v_order_date Orders.order_date%TYPE;
    v_total_amount Orders.total_amount%TYPE;
    v_house_no Orders.house_no%TYPE;
    v_sector Orders.sector%TYPE;
    v_city Orders.city%TYPE;
    v_delivery_person_id Orders.delivery_person_id%TYPE;
    v_order_status Orders.order_status%TYPE;
BEGIN
    OPEN orders_cursor;
    LOOP
        FETCH orders_cursor INTO v_order_id, v_customer_id, v_order_date, v_total_amount, v_house_no, v_sector, v_city, v_delivery_person_id, v_order_status;
        EXIT WHEN orders_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Order ID: ' || v_order_id || ', Customer: ' || v_customer_id || ', Amount: Rs.' || v_total_amount || ', Status: ' || v_order_status);
    END LOOP;
    CLOSE orders_cursor;
END;
/

DECLARE
    CURSOR order_details_cursor IS
        SELECT order_id, restaurant_id, item_name, quantity FROM order_details;

    v_order_id order_details.order_id%TYPE;
    v_restaurant_id order_details.restaurant_id%TYPE;
    v_item_name order_details.item_name%TYPE;
    v_quantity order_details.quantity%TYPE;
BEGIN
    OPEN order_details_cursor;
    LOOP
        FETCH order_details_cursor INTO v_order_id, v_restaurant_id, v_item_name, v_quantity;
        EXIT WHEN order_details_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Order Details: ' || v_order_id || ', Item: ' || v_item_name);
    END LOOP;
    CLOSE order_details_cursor;
END;
/

DECLARE
    CURSOR payment_cursor IS
        SELECT order_id, payment_id, payment_type, bill, status FROM payment;

    v_order_id payment.order_id%TYPE;
    v_payment_id payment.payment_id%TYPE;
    v_payment_type payment.payment_type%TYPE;
    v_bill payment.bill%TYPE;
    v_status payment.status%TYPE;
BEGIN
    OPEN payment_cursor;
    LOOP
        FETCH payment_cursor INTO v_order_id, v_payment_id, v_payment_type, v_bill, v_status;
        EXIT WHEN payment_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Payment: ' || v_payment_id || ', Type: ' || v_payment_type || ', Status: ' || v_status);
    END LOOP;
    CLOSE payment_cursor;
END;
/



CREATE OR REPLACE PROCEDURE Update_Customer_Details(
    p_customer_id IN NUMBER,
    p_first_name IN VARCHAR2,
    p_last_name IN VARCHAR2,
    p_house_no IN VARCHAR2,
    p_sector IN VARCHAR2,
    p_city IN VARCHAR2
)
IS
BEGIN
    UPDATE Customer
    SET 
        first_name = p_first_name,
        last_name = p_last_name,
        house_no = p_house_no,
        sector = p_sector,
        city = p_city
    WHERE customer_id = p_customer_id;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No customer found with ID ' || p_customer_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Customer with ID ' || p_customer_id || ' updated successfully.');
    END IF;

    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE Update_Customer_Column(
    p_customer_id IN NUMBER,
    p_column_name IN VARCHAR2,
    p_new_value IN VARCHAR2
)
IS
    v_sql VARCHAR2(1000);
BEGIN
    -- Construct the dynamic SQL statement
    v_sql := 'UPDATE Customer SET ' || p_column_name || ' = :1 WHERE customer_id = :2';

    -- Execute the dynamic SQL
    EXECUTE IMMEDIATE v_sql USING p_new_value, p_customer_id;

    -- Check if any row was updated
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No customer found with ID ' || p_customer_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Customer with ID ' || p_customer_id || ' updated successfully.');
    END IF;

    COMMIT;
END;
/

DECLARE
    v_customer_id NUMBER := &customer_id;
    v_column_name VARCHAR2(50) := '&column_name';
    v_new_value   VARCHAR2(100) := '&new_value';
BEGIN
    Update_Customer_Column(v_customer_id, v_column_name, v_new_value);
END;


----final update
CREATE OR REPLACE PROCEDURE Update_Table_Column(
    p_table_name   IN VARCHAR2,
    p_column_name  IN VARCHAR2,
    p_key_column   IN VARCHAR2,
    p_key_value    IN VARCHAR2,
    p_new_value    IN VARCHAR2
)
IS
    v_sql   VARCHAR2(1000);
BEGIN
    -- Construct the dynamic SQL statement
    v_sql := 'UPDATE ' || p_table_name || 
             ' SET ' || p_column_name || ' = :1 WHERE ' || p_key_column || ' = :2';

    -- Execute the dynamic SQL
    EXECUTE IMMEDIATE v_sql USING p_new_value, p_key_value;

    -- Check if any row was updated
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No record found with ' || p_key_column || ' = ' || p_key_value);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Record updated successfully in ' || p_table_name || '.');
    END IF;

    COMMIT;
END;

BEGIN
    Update_Table_Column(
        p_table_name  => '&p_table_name',
        p_column_name => '&p_column_name',
        p_key_column  => '&p_key_column',
        p_key_value   => '&p_key_value',
        p_new_value   => '&p_new_value'
    );
END;

---final delete 
CREATE OR REPLACE PROCEDURE Delete_Record_From_Table (
    p_table_name   IN VARCHAR2,
    p_key_column   IN VARCHAR2,
    p_key_value    IN VARCHAR2
)
IS
    v_sql VARCHAR2(1000);
BEGIN
    -- Construct the dynamic DELETE statement
    v_sql := 'DELETE FROM "' || UPPER(p_table_name) || 
             '" WHERE "' || UPPER(p_key_column) || '" = :1';

    -- Execute the DELETE
    EXECUTE IMMEDIATE v_sql USING p_key_value;

    -- Check if any row was deleted
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No record found in table ' || p_table_name || 
                             ' with ' || p_key_column || ' = ' || p_key_value);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Record deleted successfully from table ' || p_table_name);
    END IF;

    COMMIT;
END;
/

BEGIN
    Delete_Record_From_Table(
        p_table_name  => '&p_table_name',
        p_key_column  => '&p_key_column',
        p_key_value   => '&p_key_value' 
    );
END;
/


CREATE OR REPLACE PROCEDURE Get_Customer_Details(
    p_customer_id IN NUMBER
)
IS
    v_first_name Customer.first_name%TYPE;
    v_last_name  Customer.last_name%TYPE;
    v_house_no   Customer.house_no%TYPE;
    v_sector     Customer.sector%TYPE;
    v_city       Customer.city%TYPE;
BEGIN
    -- Fetch the customer details
    SELECT first_name, last_name, house_no, sector, city
    INTO v_first_name, v_last_name, v_house_no, v_sector, v_city
    FROM Customer
    WHERE customer_id = p_customer_id;

    -- Output the customer details
    DBMS_OUTPUT.PUT_LINE('Customer Details:');
    DBMS_OUTPUT.PUT_LINE('First Name: ' || v_first_name);
    DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('House No: ' || v_house_no);
    DBMS_OUTPUT.PUT_LINE('Sector: ' || v_sector);
    DBMS_OUTPUT.PUT_LINE('City: ' || v_city);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No customer found with ID ' || p_customer_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

DECLARE
    v_customer_id NUMBER;
BEGIN
    v_customer_id := &Enter_Customer_ID; -- User se input lega

    Get_Customer_Details(v_customer_id); -- Procedure call karega
END;
/

CREATE OR REPLACE PROCEDURE Alter_Table_Operation(
    p_table_name IN VARCHAR2,
    p_operation IN VARCHAR2,
    p_column_name IN VARCHAR2,
    p_datatype IN VARCHAR2 DEFAULT NULL
)
IS
    v_sql VARCHAR2(1000);
BEGIN
    CASE UPPER(p_operation)
        WHEN 'ADD' THEN
            v_sql := 'ALTER TABLE ' || p_table_name || ' ADD (' || p_column_name || ' ' || p_datatype || ')';
        WHEN 'MODIFY' THEN
            v_sql := 'ALTER TABLE ' || p_table_name || ' MODIFY (' || p_column_name || ' ' || p_datatype || ')';
        WHEN 'DROP' THEN
            v_sql := 'ALTER TABLE ' || p_table_name || ' DROP COLUMN ' || p_column_name;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Invalid operation. Please enter ADD, MODIFY, or DROP.');
            RETURN;
    END CASE;

    -- Execute the dynamic SQL
    EXECUTE IMMEDIATE v_sql;

    DBMS_OUTPUT.PUT_LINE('Table altered successfully.');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


DECLARE
    v_table_name VARCHAR2(50);
    v_operation VARCHAR2(20);
    v_column_name VARCHAR2(50);
    v_datatype VARCHAR2(50);
BEGIN
    v_table_name := '&Enter_Table_Name';  -- e.g., CUSTOMER
    v_operation := '&Enter_Operation';    -- e.g., ADD / MODIFY / DROP
    v_column_name := '&Enter_Column_Name'; -- e.g., age

    IF UPPER(v_operation) IN ('ADD', 'MODIFY') THEN
        v_datatype := '&Enter_DataType'; -- e.g., NUMBER(3)
    END IF;

    Alter_Table_Operation(v_table_name, v_operation, v_column_name, v_datatype);
END;
/


select * from customer;

CREATE OR REPLACE PROCEDURE Fetch_Customers
IS
    -- Cursor to select all customers
    CURSOR customer_cursor IS
        SELECT customer_id, first_name, last_name, city
        FROM Customer;

    -- Variables to hold data from cursor
    v_customer_id Customer.customer_id%TYPE;
    v_first_name Customer.first_name%TYPE;
    v_last_name Customer.last_name%TYPE;
    v_city Customer.city%TYPE;
BEGIN
    OPEN customer_cursor; -- Open cursor
    LOOP
        FETCH customer_cursor INTO v_customer_id, v_first_name, v_last_name, v_city;
        EXIT WHEN customer_cursor%NOTFOUND;

        -- Display customer data
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_customer_id ||
                             ', Name: ' || v_first_name || ' ' || v_last_name ||
                             ', City: ' || v_city);
    END LOOP;
    CLOSE customer_cursor; -- Close cursor
END;
/

SET SERVEROUTPUT ON;

BEGIN
    Fetch_Customers;
END;
/



CREATE OR REPLACE PROCEDURE Join_Two_Tables (
    p_table1         IN VARCHAR2,
    p_table2         IN VARCHAR2,
    p_join_type      IN VARCHAR2,
    p_join_condition IN VARCHAR2 DEFAULT NULL
)
IS
    v_sql        CLOB;
    v_cursor_id  INTEGER;
    v_col_cnt    INTEGER;
    v_desc_tab   DBMS_SQL.DESC_TAB;
    v_status     INTEGER;
    v_val        VARCHAR2(4000);
BEGIN
    -- Construct SQL
    IF UPPER(p_join_type) = 'NATURAL' THEN
        v_sql := 'SELECT * FROM ' || p_table1 || ' NATURAL JOIN ' || p_table2;
    ELSE
        CASE UPPER(p_join_type)
            WHEN 'INNER' THEN NULL;
            WHEN 'LEFT' THEN NULL;
            WHEN 'RIGHT' THEN NULL;
            WHEN 'FULL' THEN NULL;
            ELSE
                RAISE_APPLICATION_ERROR(-20001, 'Invalid JOIN type: ' || p_join_type);
        END CASE;

        v_sql := 'SELECT * FROM ' || p_table1 || ' a ' ||
                 UPPER(p_join_type) || ' OUTER JOIN ' || p_table2 || ' b ON ' || p_join_condition;
        IF UPPER(p_join_type) = 'INNER' THEN
            v_sql := REPLACE(v_sql, 'OUTER', ''); -- INNER JOIN does not use "OUTER"
        END IF;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Executing SQL:');
    DBMS_OUTPUT.PUT_LINE(v_sql);

    -- Use DBMS_SQL to handle dynamic result sets
    v_cursor_id := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(v_cursor_id, v_sql, DBMS_SQL.NATIVE);
    DBMS_SQL.DESCRIBE_COLUMNS(v_cursor_id, v_col_cnt, v_desc_tab);

    -- Define columns dynamically
    FOR i IN 1 .. v_col_cnt LOOP
        DBMS_SQL.DEFINE_COLUMN(v_cursor_id, i, v_val, 4000);
    END LOOP;

    -- Execute
    v_status := DBMS_SQL.EXECUTE(v_cursor_id);

    -- Fetch and print rows
    WHILE DBMS_SQL.FETCH_ROWS(v_cursor_id) > 0 LOOP
        FOR i IN 1 .. v_col_cnt LOOP
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, i, v_val);
            DBMS_OUTPUT.PUT_LINE(v_desc_tab(i).col_name || ' = ' || v_val);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('--------------------------');
    END LOOP;

    DBMS_SQL.CLOSE_CURSOR(v_cursor_id);

EXCEPTION
    WHEN OTHERS THEN
        IF DBMS_SQL.IS_OPEN(v_cursor_id) THEN
            DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
        END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

SET SERVEROUTPUT ON;

DECLARE
    v_table1         VARCHAR2(100) := '&table1';
    v_table2         VARCHAR2(100) := '&table2';
    v_join_type      VARCHAR2(20)  := '&join_type';
    v_join_condition VARCHAR2(500);
BEGIN
    IF UPPER(v_join_type) = 'NATURAL' THEN
        v_join_condition := NULL;
    ELSE
        v_join_condition := '&join_condition';
    END IF;

    Join_Two_Tables(
        p_table1         => v_table1,
        p_table2         => v_table2,
        p_join_type      => v_join_type,
        p_join_condition => v_join_condition
    );
END;
/
 
-- additional functionalities
--1
CREATE OR REPLACE PROCEDURE Get_Most_Ordered_Item IS
    v_item_name VARCHAR2(100);
    v_quantity NUMBER;
BEGIN
    SELECT item_name, SUM(quantity)
    INTO v_item_name, v_quantity
    FROM Order_Details
    GROUP BY item_name
    ORDER BY SUM(quantity) DESC
    FETCH FIRST 1 ROWS ONLY;

    DBMS_OUTPUT.PUT_LINE('Most ordered item: ' || v_item_name || ' | Quantity: ' || v_quantity);
END;
/

BEGIN
    Get_Most_Ordered_Item;
END;
/

--2
CREATE OR REPLACE PROCEDURE Get_Top_Customer IS
    v_customer_id   Customer.customer_id%TYPE;
    v_first_name    Customer.first_name%TYPE;
    v_order_count   NUMBER;
BEGIN
    -- Retrieve the customer_id with the highest number of orders
    SELECT customer_id, COUNT(*) AS order_count
    INTO v_customer_id, v_order_count
    FROM Orders
    GROUP BY customer_id
    ORDER BY COUNT(*) DESC
    FETCH FIRST 1 ROWS ONLY;

    -- Fetch the first name of the customer using the obtained customer_id
    SELECT first_name
    INTO v_first_name
    FROM Customer
    WHERE customer_id = v_customer_id;

    -- Display the result
    DBMS_OUTPUT.PUT_LINE('Top Customer ID: ' || v_customer_id || 
                         ' | Name: ' || v_first_name || 
                         ' | Total Orders: ' || v_order_count);
END;
/

BEGIN
    Get_Top_Customer;
END;
/


--3
CREATE OR REPLACE PROCEDURE Get_Revenue_By_Restaurant IS
BEGIN
    FOR rec IN (
        SELECT od.restaurant_id, r.restaurant_name, SUM(o.total_amount) AS revenue
        FROM Orders o
        JOIN Order_Details od ON o.order_id = od.order_id
        JOIN Restaurant r ON od.restaurant_id = r.restaurant_id
        GROUP BY od.restaurant_id, r.restaurant_name
        ORDER BY revenue DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Restaurant: ' || rec.restaurant_name || ' | Revenue: ' || rec.revenue);
    END LOOP;
END;
/

BEGIN
    Get_Revenue_By_Restaurant;
END;
/

--4
CREATE OR REPLACE PROCEDURE Get_Top_Delivery_Person IS
    v_id DeliveryPerson.delivery_person_id%TYPE;
    v_count NUMBER;
BEGIN
    SELECT delivery_person_id, COUNT(*)
    INTO v_id, v_count
    FROM Orders
    GROUP BY delivery_person_id
    ORDER BY COUNT(*) DESC
    FETCH FIRST 1 ROWS ONLY;

    DBMS_OUTPUT.PUT_LINE('Top Delivery Person ID: ' || v_id || ' | Deliveries: ' || v_count);
END;
/
BEGIN
    Get_Top_Delivery_Person;
END;
/

--5
CREATE OR REPLACE PROCEDURE Get_Available_Items(p_restaurant_id IN NUMBER) IS
BEGIN
    FOR rec IN (
        SELECT m.item_name
        FROM Menu m
        JOIN Restaurant_Menu rm ON m.menu_id = rm.menu_id AND m.restaurant_id = rm.restaurant_id
        WHERE rm.availability = 'yes' AND m.restaurant_id = p_restaurant_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Available Item: ' || rec.item_name);
    END LOOP;
END;
/

BEGIN
    Get_Available_Items(p_restaurant_id => &restaurant_id);
END;
/

--6
CREATE OR REPLACE PROCEDURE Get_Vegan_Items IS
BEGIN
    FOR rec IN (
        SELECT m.item_name, r.restaurant_name
        FROM Veg v
        JOIN Menu m ON m.menu_id = v.menu_id AND m.restaurant_id = v.restaurant_id
        JOIN Restaurant r ON r.restaurant_id = m.restaurant_id
        WHERE LOWER(v.vegan_friendly) = 'yes'
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Vegan Item: ' || rec.item_name || ' | Restaurant: ' || rec.restaurant_name);
    END LOOP;
END;
/

BEGIN
    Get_Vegan_Items;
END;
/

--7
CREATE OR REPLACE PROCEDURE Get_Orders_By_Customer(p_customer_id IN NUMBER) IS
BEGIN
    FOR rec IN (
        SELECT order_id, order_date, total_amount
        FROM Orders
        WHERE customer_id = p_customer_id
        ORDER BY order_date DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Order ID: ' || rec.order_id || ' | Date: ' || rec.order_date || ' | Amount: ' || rec.total_amount);
    END LOOP;
END;
/

BEGIN
    Get_Orders_By_Customer(p_customer_id => &p_customer_id);
END;
/

--8
CREATE OR REPLACE PROCEDURE Get_Unpaid_Orders IS
BEGIN
    FOR rec IN (
        SELECT p.order_id, o.customer_id
        FROM Payment p
        JOIN Orders o ON o.order_id = p.order_id
        WHERE LOWER(p.status) <> 'completed'
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Unpaid Order: ' || rec.order_id || ' | Customer ID: ' || rec.customer_id);
    END LOOP;
END;
/

BEGIN
    Get_Unpaid_Orders;
END;
/

--9
CREATE OR REPLACE PROCEDURE Get_Restaurants_By_City(p_city IN VARCHAR2) IS
BEGIN
    FOR rec IN (
        SELECT restaurant_name, shop_no, sector
        FROM Restaurant
        WHERE LOWER(city) = LOWER(p_city)
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Restaurant: ' || rec.restaurant_name || ', Shop No: ' || rec.shop_no || ', Sector: ' || rec.sector);
    END LOOP;
END;
/

BEGIN
    Get_Restaurants_By_City(p_city => '&p_city');
END;
/

--10
CREATE OR REPLACE PROCEDURE Get_Top_Cuisine IS
    v_cuisine VARCHAR2(50);
    v_total NUMBER;
BEGIN
    SELECT cuisine_type, COUNT(*) 
    INTO v_cuisine, v_total
    FROM Menu m
    JOIN Order_Details od ON m.item_name = od.item_name AND m.restaurant_id = od.restaurant_id
    GROUP BY cuisine_type
    ORDER BY COUNT(*) DESC
    FETCH FIRST 1 ROWS ONLY;

    DBMS_OUTPUT.PUT_LINE('Top Cuisine: ' || v_cuisine || ' | Orders: ' || v_total);
END;
/

BEGIN
    Get_Top_Cuisine;
END;
/

--11
CREATE OR REPLACE PROCEDURE List_Customers_With_No_Orders IS
BEGIN
    FOR rec IN (
        SELECT c.customer_id, c.first_name, c.last_name
        FROM Customer c
        WHERE NOT EXISTS (
            SELECT 1 FROM Orders o WHERE o.customer_id = c.customer_id
        )
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || rec.customer_id || 
                             ', Name: ' || rec.first_name || ' ' || rec.last_name);
    END LOOP;
END;
/

BEGIN
    List_Customers_With_No_Orders;
END;
/

--12
CREATE OR REPLACE PROCEDURE Calculate_Average_Order_Value IS
    v_avg_value NUMBER;
BEGIN
    SELECT AVG(total_amount) INTO v_avg_value FROM Orders;

    DBMS_OUTPUT.PUT_LINE('Average Order Value: ' || ROUND(v_avg_value, 2));
END;
/

BEGIN
    Calculate_Average_Order_Value;
END;
/

--13
CREATE OR REPLACE PROCEDURE Get_Customer_Contact_Info(p_customer_id IN NUMBER) IS
BEGIN
    FOR rec IN (
        SELECT contact_no
        FROM Customer_Contact
        WHERE customer_id = p_customer_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Contact Number: ' || rec.contact_no);
    END LOOP;
END;
/

BEGIN
    Get_Customer_Contact_Info(p_customer_id => &p_customer_id);
END;
/

--14
CREATE OR REPLACE PROCEDURE Get_Top_Customers_By_Spend(p_top_n IN NUMBER) IS
BEGIN
    IF p_top_n <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Please enter a valid number greater than 0.');
        RETURN;
    END IF;

    FOR rec IN (
        SELECT customer_id, first_name, last_name, total_spent
        FROM (
            SELECT c.customer_id, c.first_name, c.last_name, SUM(o.total_amount) AS total_spent
            FROM Customer c
            JOIN Orders o ON c.customer_id = o.customer_id
            GROUP BY c.customer_id, c.first_name, c.last_name
            ORDER BY total_spent DESC
        )
        FETCH FIRST p_top_n ROWS ONLY
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || rec.customer_id ||
                             ', Name: ' || rec.first_name || ' ' || rec.last_name ||
                             ', Total Spent: ' || rec.total_spent);
    END LOOP;
END;
/


BEGIN
    Get_Top_Customers_By_Spend(p_top_n => &top_n);
END;
/

--15
CREATE OR REPLACE PROCEDURE Get_Daily_Sales_Report IS
BEGIN
    FOR rec IN (
        SELECT order_date, SUM(total_amount) AS daily_total
        FROM Orders
        GROUP BY order_date
        ORDER BY order_date
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(rec.order_date, 'YYYY-MM-DD') || ', Total Sales: ' || rec.daily_total);
    END LOOP;
END;
/
BEGIN
    Get_Daily_Sales_Report;
END;
/

--16
CREATE OR REPLACE PROCEDURE Get_Vehicle_Usage IS
BEGIN
    FOR rec IN (
        SELECT v.vehicle_id, v.license_plate, COUNT(o.order_id) AS deliveries_made
        FROM Vehicle v
        JOIN DeliveryPerson dp ON v.vehicle_id = dp.vehicle_id
        JOIN Orders o ON dp.delivery_person_id = o.delivery_person_id
        GROUP BY v.vehicle_id, v.license_plate
        order by deliveries_made desc
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Vehicle ID: ' || rec.vehicle_id || ', License Plate: ' || rec.license_plate || ', Deliveries Made: ' || rec.deliveries_made);
    END LOOP;
END;
/
BEGIN
    Get_Vehicle_Usage;
END;
/

--17
CREATE OR REPLACE PROCEDURE List_Menu_By_Cuisine(p_cuisine_type IN VARCHAR2) IS
BEGIN
    FOR rec IN (
        SELECT item_name, price
        FROM Menu
        WHERE upper(cuisine_type) = upper(p_cuisine_type)
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Item: ' || rec.item_name || ', Price: ' || rec.price);
    END LOOP;
END;
/

BEGIN
    List_Menu_By_Cuisine(p_cuisine_type => '&p_cuisine_type');
END;
/

--18
CREATE OR REPLACE PROCEDURE Get_Customer_Order_History(p_customer_id IN NUMBER) IS
BEGIN
    FOR rec IN (
        SELECT order_id, order_date, total_amount, order_status
        FROM Orders
        WHERE customer_id = p_customer_id
        ORDER BY order_date DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Order ID: ' || rec.order_id || ', Date: ' || TO_CHAR(rec.order_date, 'YYYY-MM-DD') || ', Amount: ' || rec.total_amount || ', Status: ' || rec.order_status);
    END LOOP;
END;
/

BEGIN
    Get_Customer_Order_History(p_customer_id => &p_customer_id);
END;
/

--19
CREATE OR REPLACE PROCEDURE Manage_Constraint (
    p_table_name       IN VARCHAR2,
    p_action           IN VARCHAR2,
    p_constraint_type  IN VARCHAR2,
    p_constraint_name  IN VARCHAR2,
    p_column_name      IN VARCHAR2,
    p_reference_table  IN VARCHAR2 DEFAULT NULL,
    p_reference_column IN VARCHAR2 DEFAULT NULL,
    p_check_condition  IN VARCHAR2 DEFAULT NULL
) IS
    v_sql VARCHAR2(1000);
BEGIN
    IF UPPER(p_action) = 'ADD' THEN
        IF UPPER(p_constraint_type) = 'PRIMARY KEY' THEN
            v_sql := 'ALTER TABLE ' || p_table_name || ' ADD CONSTRAINT ' || p_constraint_name ||
                     ' PRIMARY KEY (' || p_column_name || ')';
        ELSIF UPPER(p_constraint_type) = 'UNIQUE' THEN
            v_sql := 'ALTER TABLE ' || p_table_name || ' ADD CONSTRAINT ' || p_constraint_name ||
                     ' UNIQUE (' || p_column_name || ')';
        ELSIF UPPER(p_constraint_type) = 'CHECK' THEN
            v_sql := 'ALTER TABLE ' || p_table_name || ' ADD CONSTRAINT ' || p_constraint_name ||
                     ' CHECK (' || p_check_condition || ')';
        ELSIF UPPER(p_constraint_type) = 'FOREIGN KEY' THEN
            v_sql := 'ALTER TABLE ' || p_table_name || ' ADD CONSTRAINT ' || p_constraint_name ||
                     ' FOREIGN KEY (' || p_column_name || ') REFERENCES ' || p_reference_table ||
                     ' (' || p_reference_column || ')';
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unsupported constraint type for ADD action.');
            RETURN;
        END IF;
    ELSIF UPPER(p_action) = 'DROP' THEN
        v_sql := 'ALTER TABLE ' || p_table_name || ' DROP CONSTRAINT ' || p_constraint_name;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Unsupported action. Use ADD or DROP.');
        RETURN;
    END IF;

    EXECUTE IMMEDIATE v_sql;
    DBMS_OUTPUT.PUT_LINE('Constraint ' || p_action || ' operation completed successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
    Manage_Constraint(
        p_table_name       => '&table_name',
        p_action           => '&action',
        p_constraint_type  => '&constraint_type',
        p_constraint_name  => '&constraint_name',
        p_column_name      => '&column_name',
        p_reference_table  => '&reference_table',
        p_reference_column => '&reference_column',
        p_check_condition  => '&check_condition'
    );
END;
/

CREATE OR REPLACE PROCEDURE Insert_Into_Table (
    p_table_name IN VARCHAR2
)
IS
    v_sql        VARCHAR2(4000);
    v_columns    VARCHAR2(1000);
    v_values     VARCHAR2(1000);
    v_col_name   VARCHAR2(100);
    v_data_type  VARCHAR2(100);
    CURSOR col_cursor IS
        SELECT column_name, data_type
        FROM all_tab_columns
        WHERE table_name = UPPER(p_table_name)
          AND owner = USER
        ORDER BY column_id;
BEGIN
    v_columns := '';
    v_values  := '';
    
    FOR col_rec IN col_cursor LOOP
        v_columns := v_columns || col_rec.column_name || ', ';
        
        -- Prompt user for input
        DBMS_OUTPUT.PUT('Enter value for ' || col_rec.column_name || ' (' || col_rec.data_type || '): ');
        -- Note: In SQL*Plus or SQL Developer, use substitution variables
        -- For demonstration, we'll use substitution variables
        v_values := v_values || '''&' || col_rec.column_name || ''', ';
    END LOOP;
    
    -- Remove trailing commas and spaces
    v_columns := RTRIM(v_columns, ', ');
    v_values  := RTRIM(v_values, ', ');
    
    v_sql := 'INSERT INTO ' || p_table_name || ' (' || v_columns || ') VALUES (' || v_values || ')';
    
    EXECUTE IMMEDIATE v_sql;
    
    DBMS_OUTPUT.PUT_LINE('Data inserted into table ' || p_table_name || ' successfully.');
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

DECLARE
    v_table_name VARCHAR2(100) := UPPER('&table_name');
    v_sql        VARCHAR2(4000);
    v_columns    VARCHAR2(1000);
    v_values     VARCHAR2(1000);
BEGIN
    FOR col_rec IN (
        SELECT column_name
        FROM all_tab_columns
        WHERE table_name = v_table_name
          AND owner = USER
        ORDER BY column_id
    ) LOOP
        v_columns := v_columns || col_rec.column_name || ', ';
        v_values  := v_values || '''&' || col_rec.column_name || ''', ';
    END LOOP;

    -- Remove trailing commas and spaces
    v_columns := RTRIM(v_columns, ', ');
    v_values  := RTRIM(v_values, ', ');

    v_sql := 'INSERT INTO ' || v_table_name || ' (' || v_columns || ') VALUES (' || v_values || ')';

    EXECUTE IMMEDIATE v_sql;

    DBMS_OUTPUT.PUT_LINE('Data inserted into table ' || v_table_name || ' successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/




--TRIGGERS
--1 To Auto assign delivery person with least no of orders 
CREATE OR REPLACE TRIGGER trg_assign_delivery_person
BEFORE INSERT ON Orders
FOR EACH ROW
DECLARE
    v_delivery_id NUMBER;
BEGIN
    SELECT delivery_person_id
    INTO v_delivery_id
    FROM (
        SELECT d.delivery_person_id
        FROM DeliveryPerson d
        LEFT JOIN Orders o ON d.delivery_person_id = o.delivery_person_id
        GROUP BY d.delivery_person_id
        ORDER BY COUNT(o.order_id)
    )
    WHERE ROWNUM = 1;

    -- Set the delivery person in the new row
    :NEW.delivery_person_id := v_delivery_id;
END;

--test trigger 1 
INSERT INTO Orders (
    order_id, customer_id, order_date, total_amount,
    house_no, sector, city, delivery_person_id, order_status
) VALUES
(115, 11, TO_DATE('2025-04-01 12:30', 'YYYY-MM-DD HH24:MI'), 450.00, 'H101', 'Sector 1', 'Delhi', 2, 'Pending');

select order_id,delivery_person_id from orders where order_id=115;

--trigger 2 Auto-create Payment record when Order is completed
CREATE OR REPLACE TRIGGER trg_update_restaurant_sales
AFTER INSERT ON Payment
FOR EACH ROW
DECLARE
    v_restaurant_id NUMBER;
BEGIN
    -- Find restaurant_id from Order_Details
    SELECT restaurant_id INTO v_restaurant_id
    FROM Order_Details
    WHERE order_id = :NEW.order_id
    AND ROWNUM = 1; -- In case multiple restaurants are involved

    -- Add a column 'total_sales' to Restaurant if it doesn't exist
    UPDATE Restaurant
    SET total_sales = NVL(total_sales, 0) + :NEW.bill
    WHERE restaurant_id = v_restaurant_id;
END;
/

--test trigger2
-- Insert a dummy order and order details (if not already present)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, house_no, sector, city, delivery_person_id, order_status)
VALUES (101, 1, SYSDATE, 0, '12A', 'Sector 9', 'CityX', 1, 'In Progress');

INSERT INTO Order_Details (order_id, restaurant_id, item_name, quantity)
VALUES (101, 10, 'Paneer Tikka', 2);

-- Then update to trigger the trigger
UPDATE Orders
SET order_status = 'Completed'
WHERE order_id = 101;

ALTER TABLE Restaurant ADD total_sales NUMBER(10,2) DEFAULT 0;


-- Verify the result
SELECT * FROM orders WHERE order_id = 101;

INSERT INTO Menu (menu_id, restaurant_id, item_name, description, price, cuisine_type)
VALUES (1, 10, 'Paneer Tikka', 'Grilled cottage cheese', 250, 'Indian');

INSERT INTO Restaurant_Menu (menu_id, restaurant_id, availability)
VALUES (1, 10, 'Yes');

SELECT * FROM Menu WHERE item_name = 'Paneer Tikka' AND restaurant_id = 10;
SELECT * FROM Order_Details WHERE order_id = 101;

--trigger 3  Prevent Deletion of a Customer with Active Orders
CREATE OR REPLACE TRIGGER trg_prevent_customer_delete
BEFORE DELETE ON Customer
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Orders WHERE customer_id = :OLD.customer_id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cannot delete customer with existing orders.');
    END IF;
END;
/



--test trigger 3
-- Drop old FK constraint on Orders
ALTER TABLE Orders DROP CONSTRAINT FK_Orders_Customer;

-- Recreate FK without ON DELETE CASCADE
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customer
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id);

-- Insert test data
INSERT INTO Customer VALUES (999, 'Test', 'Block', 'A1', '9', 'Delhi');
INSERT INTO Orders VALUES (456, 999, SYSDATE, 400, 'A1', '9', 'Delhi', 1, 'Pending');

-- Try delete (should fail)
DELETE FROM Customer WHERE customer_id = 999;
-- ❌ Fails with ORA-20001

-- Try another customer (no orders)
INSERT INTO Customer VALUES (1000, 'Free', 'Delete', 'B1', '10', 'Delhi');
DELETE FROM Customer WHERE customer_id = 1000;
-- ✅ Succeeds

--trigger 4  Auto-Set Order Status to 'Pending' on Insert
CREATE OR REPLACE TRIGGER trg_default_order_status
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    IF :NEW.order_status IS NULL THEN
        :NEW.order_status := 'Pending';
    END IF;
END;
/

--trigger 4 testing
-- Step 1: Insert a new order without specifying status
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, house_no, sector, city, delivery_person_id)
VALUES (302, 201, SYSDATE, 400, '101', '9', 'Delhi', 1);

-- Step 2: Check what status was inserted
SELECT order_id,order_status FROM Orders WHERE order_id = 302;

-- ✅ Expected: order_status = 'Pending'

--trigger 5 Prevent Menu Deletion If Used in Orders
CREATE OR REPLACE TRIGGER trg_prevent_menu_delete
BEFORE DELETE ON Menu
FOR EACH ROW
DECLARE
    v_exists NUMBER;
BEGIN
    -- Check if the menu item is used in any order details
    SELECT COUNT(*)
    INTO v_exists
    FROM Order_Details
    WHERE restaurant_id = :OLD.restaurant_id
    AND item_name = :OLD.item_name;  -- Referencing the 'item_name' column instead of 'menu_id'

    -- If the item is used in any order details, raise an error
    IF v_exists > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cannot delete menu item. It is used in existing orders.');
    END IF;
END;
/


--trigger 5 testing

-- Step 1: Insert a payment
-- Insert the missing restaurant into the Restaurant table
INSERT INTO Restaurant (restaurant_id, restaurant_name, shop_no, sector, city, website, opening_hours, closing_hours)
VALUES (201, 'Tasty Bites', '12', 'Sector 5', 'CityX', 'www.tastybites.com', '10:00 AM', '11:00 PM');

-- Insert Menu data
INSERT INTO Menu (menu_id, restaurant_id, item_name, description, price, cuisine_type)
VALUES (1001, 201, 'Burger', 'Tasty Veg Burger', 120, 'Fast Food');

-- Insert into Restaurant_Menu
INSERT INTO Restaurant_Menu (menu_id, restaurant_id, availability)
VALUES (1001, 201, 'Yes');

-- Insert Orders data
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, house_no, sector, city, delivery_person_id, order_status)
VALUES (501, 1, SYSDATE, 240, 'A1', 'Sector 5', 'CityX', 1, 'In Progress');

-- Insert Order_Details with the correct restaurant_id
INSERT INTO Order_Details (order_id, restaurant_id, item_name, quantity)
VALUES (501, 201, 'Burger', 2);


BEGIN
    DELETE FROM Menu
    WHERE menu_id = 1001 AND restaurant_id = 201;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); -- Print error message
END;
/

-- Step 3: Confirm that the delete was prevented due to the trigger
-- Check that the menu item still exists in the Menu table
SELECT * FROM Menu WHERE menu_id = 1001 AND restaurant_id = 201;

SELECT * FROM user_errors WHERE name = 'TRG_PREVENT_MENU_DELETE';

DECLARE
    -- Declare the cursor for fetching customer details along with contact and email
    CURSOR customer_details_cursor IS
        SELECT c.customer_id, 
               c.first_name, 
               c.last_name, 
               c.house_no, 
               c.sector, 
               c.city, 
               cc.contact_no, 
               ce.email
        FROM Customer c
        LEFT JOIN Customer_Contact cc ON c.customer_id = cc.customer_id
        LEFT JOIN Customer_Email ce ON c.customer_id = ce.customer_id
        ORDER BY c.customer_id;  -- You can change this to any other order you prefer
    
    -- Declare a variable to store the fetched cursor data
    customer_info customer_details_cursor%ROWTYPE;
BEGIN
    -- Open the cursor
    OPEN customer_details_cursor;

    -- Loop through all the records fetched by the cursor
    LOOP
        -- Fetch each row into the variable
        FETCH customer_details_cursor INTO customer_info;

        -- Exit the loop when no more rows are available
        EXIT WHEN customer_details_cursor%NOTFOUND;

        -- Output the customer information
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || customer_info.customer_id);
        DBMS_OUTPUT.PUT_LINE('Name: ' || customer_info.first_name || ' ' || customer_info.last_name);
        DBMS_OUTPUT.PUT_LINE('Address: ' || customer_info.house_no || ', ' || customer_info.sector || ', ' || customer_info.city);
        DBMS_OUTPUT.PUT_LINE('Contact No: ' || customer_info.contact_no || ', Email: ' || customer_info.email);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END LOOP;

    -- Close the cursor
    CLOSE customer_details_cursor;
END;
/